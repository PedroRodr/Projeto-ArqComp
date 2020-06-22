; **********************************************
; *
; * Projeto - Arquitectura de Computadores
; *
; **********************************************
; *
; * 93783  José Pedro Garrucho de Oliveira
; *	94062  Pedro de Carvalho Rodrigues
; * 94245  Tiago Moço dos Santos
; *
; **********************************************



; ***************************
; * Constantes
; ***************************

; usadas no teclado
PKEYIN	EQU	0C000H  ; endereço da entrada do teclado
PKEYOUT	EQU	0E000H	; endereço da saida do teclado
TECLA	EQU	910H	; endereço de memória onde se guarda a tecla
TECLA2	EQU 912H 	; variável de controle do teclado
LINHA	EQU	8		; posição inicial da linha do teclado


; Movimento cima esquerda	: 1
; Movimento cima			: 2
; Movimento cima direita 	: 3
; Movimento esquerda		: 5
; Movimento direita			: 7
; Movimento baixo esquerda	: 9
; Movimento baixo 			: A
; Movimento baixo direita 	: B
; Atirar torpedo 			: 6
; Começar o jogo			: C
; Terminar o jogo			: D


; strings da movimentação
PLACE 2000H
mascaraPixel: STRING 80H, 40H, 20H, 10H, 08H, 04H, 02H, 01H
movimentoX: STRING 	0, -1,  0,  1,  0, -1,  0,  1,	0, -1,  0,  1,	0,  0,  0,  0
movimentoY: STRING	0, -1, -1, -1, 	0,  0,  0,  0,	0,  1,  1,  1, 	0,  0,  0,  0



subMascara:	STRING 6, 3		; tamanho(x,y) da caixa do submarino, necessária para a escrita na pixel screen
			STRING 0 , 0 , 1 , 1 , 0 , 0
			STRING 0 , 0 , 0 , 1 , 0 , 0
			STRING 1 , 1 , 1 , 1 , 1 , 1
subPosX EQU 1000H	; endereço X do submarino
subPosY EQU 1002H	; endereço Y do submarino


barcoUmMascara: STRING 8, 6		; tamanho(x,y) da caixa do barco Um, necessária para a escrita na pixel screen
				STRING 0 , 1 , 0 , 0 , 0 , 0 , 0 , 0
				STRING 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0
				STRING 0 , 0 , 1 , 0 , 0 , 0 , 0 , 0
				STRING 1 , 1 , 1 , 1 , 1 , 1 , 1 , 1
				STRING 0 , 1 , 1 , 1 , 1 , 1 , 1 , 0
				STRING 0 , 0 , 1 , 1 , 1 , 1 , 0 , 0
barcoUmPosX	EQU 1004H	; endereço X do barco Um
barcoUmPosY EQU 1006H	; endereço Y do barco Um
auxClockBarcoUm		EQU 1024H	 ; variável auxiliar para movimentação do barco Um

barcoDoisMascara: STRING 6, 5 	; tamanho(x,y) da caixa do barco Dois, necessária para a escrita na pixel screen
				  STRING 0 , 1 , 0 , 0 , 0 , 0
				  STRING 0 , 0 , 1 , 0 , 0 , 0
				  STRING 0 , 0 , 1 , 0 , 0 , 0
				  STRING 1 , 1 , 1 , 1 , 1 , 1
				  STRING 0 , 1 , 1 , 1 , 1 , 0
barcoDoisPosX EQU 1008H 	; endereço X do barco Dois
barcoDoisPosY EQU 100AH		; endereço Y do barco Dois
auxClockBarcoDois	EQU 1026H	 ; variável auxiliar para movimentação do barco Dois


torpedoMascara:	STRING 1, 3		; tamanho(x,y) da caixa do torpedo, necessária para a escrita na pixel screen
				STRING 1
				STRING 1
				STRING 1
torpedoPosX EQU 100CH		; endereço X do torpedo
torpedoPosY EQU 100EH		; endereço Y do torpedo
auxClockTorpedo		EQU 1028H ; variável auxiliar para movimentação do torpedo
auxDesTorpedo 		EQU 1030H ; variável para desenhar o torpedo


balaMascara: STRING 1, 1		; tamanho(x,y) da caixa da bala, necessária para a escrita na pixel screen
			 STRING 1
balaPosX EQU 1010H		; endereço X da bala
balaPosY EQU 1012H		; endereço Y da bala
auxClockBala EQU 102AH ; variável auxiliar para movimentação doa bala


fimMascara: STRING 12, 6 	; tamanho(x,y) da caixa do Fim, necessária para a escrita na pixel screen
			STRING 1 , 1 , 1 , 1 , 0 , 1 , 0 , 1 , 0 , 0 , 0 , 1
 			STRING 1 , 0 , 0 , 0 , 0 , 1 , 0 , 1 , 1 , 0 , 1 , 1
			STRING 1 , 1 , 1 , 0 , 0 , 1 , 0 , 1 , 0 , 1 , 0 , 1
			STRING 1 , 0 , 0 , 0 , 0 , 1 , 0 , 1 , 0 , 0 , 0 , 1
			STRING 1 , 0 , 0 , 0 , 0 , 1 , 0 , 1 , 0 , 0 , 0 , 1
			STRING 1 , 0 , 0 , 0 , 0 , 1 , 0 , 1 , 0 , 0 , 0 , 1
fimPosX EQU 1034H 	; endereço X do fim
fimPosY EQU 1036H	; endereço Y do fim

clockUm		EQU 1020H 	; endereço do variável do clock Um
clockDois	EQU 1022H 	; endereço da variável do clock Dois

numAleatorio EQU 102CH 	; endereço do número aleatório utilizado para os barcos e bala
auxNumAlea 	 EQU 102EH 	; endereço da variável auxiliar da função do número aleatório

auxFim	EQU 1032H; 	endereço da variável que analisa se é o fim do jogo

scoreBoard EQU 1038H  	; endereço do placar
PLACAR EQU 0A000H 	; endereço do periférico do placar

; pilha
pilha:	TABLE 400H
fimPilha:	




; ***************************
; * Main
; ***************************

PLACE 0H
MOV     SP, fimPilha

main:
	CALL	inicio					; inicio do programa, posiciona submarino na posição
	ciclo:	CALL clocks 			; função que chama os clocks
			CALL numeroAleatorio 	; função que pega o número aleatório
			CALL inicTeclado		; rotina de identificação da tecla premida
			CALL analisaFim			; rotina que analisa o estado do jogo
			CALL estadoJogo 		; rotina de estado do jogo
			JMP ciclo 				; ciclo principal do programa









; ***************************
; * Inicialização
; ***************************

inicio:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4

	;inicialização geral do programa (posição inicial do barco, pontuação, etc...)
	;posição inicial do submarino
	MOV	 R1, subPosX
	MOV  R2, subPosY
	MOV  R3, 13
	MOVB [R1], R3	; coordenada X inicial do submarino
	MOV  R3, 26
	MOVB [R2], R3	; coordenada Y inicial do submarino

	;posição inicial do barco Um
	MOV	 R1, barcoUmPosX
	MOV  R2, barcoUmPosY
	MOV  R3, 0
	MOVB [R1], R3	; coordenada X inicial do barco Um
	MOV  R3, 0
	MOVB [R2], R3	; coordenada Y inicial do barco Um

	;posição inicial do barco Dois
	MOV	 R1, barcoDoisPosX
	MOV  R2, barcoDoisPosY
	MOV  R3, 15
	MOVB [R1], R3	; coordenada X inicial do barco Dois
	MOV  R3, 0
	MOVB [R2], R3	; coordenada Y inicial do barco Dois

	;posição inicial da Bala
	MOV	 R1, balaPosX
	MOV  R2, balaPosY
	MOV  R3, 0
	MOVB [R1], R3	; coordenada X inicial da bala
	MOV  R3, 25
	MOVB [R2], R3	; coordenada Y inicial da bala

	;posição inicial do Torpedo
	MOV	 R1, torpedoPosX
	MOV  R2, torpedoPosY
	MOV  R3, 31
	MOVB [R1], R3	; coordenada X inicial do torpedo
	MOV  R3, 29
	MOVB [R2], R3	; coordenada Y inicial do torpedo

	MOV R1, auxDesTorpedo 		; endereço da variável auxiliar de desenho do torpedo
	MOV R2, 0					; inicializa com zero
	MOVB [R1], R2				; atualiza com zero

	;posição inicial do Fim
	MOV	 R1, fimPosX
	MOV  R2, fimPosY
	MOV  R3, 10
	MOVB [R1], R3	; coordenada X inicial do fim
	MOV  R3, 13
	MOVB [R2], R3	; coordenada Y inicial do fim

	MOV R1, TECLA2 	; endereço de onde está a tecla premida
	MOV R2, 1FH		; valor qualquer
	MOVB [R1], R2	; valor da tecla premida

	MOV R1, numAleatorio 	; endereço do numero aleatorio
	MOV R2, 0				; inicializa com zero
	MOVB [R1], R2			; atualiza com zero

	MOV R1, auxNumAlea	 	; endereço da variável auxiliar do numero aleatorio
	MOV R2, 0				; inicializa com zero
	MOVB [R1], R2			; atualiza com zero

	MOV R1, auxClockBarcoUm	 	; endereço da variável auxiliar do clock Um
	MOV R2, 0					; inicializa com zero
	MOVB [R1], R2				; atualiza com zero

	MOV R1, auxClockBarcoDois 	; endereço da variável auxiliar do clock Dois
	MOV R2, 0					; inicializa com zero
	MOVB [R1], R2				; atualiza com zero
 
	MOV R1, scoreBoard		 	; endereço do placar
	MOV R2, 0					; inicializa com zero
	MOVB [R1], R2				; atualiza com zero
	
	POP R4
	POP R3
	POP R2
	POP R1
	RET 	



; ***************************
; * Teclado
; ***************************

inicTeclado: 
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9

; inicializações da rotina do teclado
	MOV 	R5, TECLA 	; endereço da memória em que se guarda a tecla
	MOV		R1, LINHA	; testar a linha 4 
	MOV		R2, PKEYIN	; R2 com o endereço da entrada do teclado
	MOV 	R9, PKEYOUT ; R9 com o endereço da saida do teclado
	MOV 	R6, 4		; contador linha 0-3
	MOV 	R7, 0		; contador coluna 0-3

cicloTeclado:
; ciclo geral da rotina do teclado
	MOV 	R7, 0		; volta o contador coluna a 0
	AND		R1, R1      ; testa se linha vale zero
	JZ 		teclaZero 	; vai ao reset da linha
	MOVB 	[R2], R1	; escrever no porto de saída
	MOVB 	R3, [R9]	; ler do porto de entrada
	MOV 	R8, 0FH		; máscara 0000 1111, para buscar os digitos que serão usados no teclado
	AND 	R3, R8		; dígitos que serão usados no teclado
	SUB		R6, 1		; variavel de controle linha 0-3
	SHR     R1, 1		; muda a linha para próxima iteração
	AND 	R3, R3		; afectar as flags (MOVs não afectam as flags)
	JZ 	    cicloTeclado; nenhuma tecla premida

contc:
; transforma {1,2,4,8} da coluna em {0, 1, 2, 3}
	SHR 	R3, 1 		; contagem do numero de colunas
	AND 	R3, R3 		; afectar as flags
	JZ 		gravaTeclado; grava caso tenha terminado de contar
	ADD 	R7, 1 		; soma ao contador coluna
	JMP     contc		; volta ao loop do contador coluna

gravaTeclado:	
; grava a tecla premida em memória
	SHL  	R6, 2 		; multiplica L por 4
	ADD		R7, R6		; soma C + 4L
	MOVB 	[R5], R7	; guarda tecla premida em memória


fimTeclado:
	POP		R9
	POP		R8
	POP		R7
	POP 	R6
	POP		R5
	POP		R3
	POP		R2
	POP		R1
	RET 				; volta pra rotina do programa

resetl:
; rotina auxiliar para resetar o valor inicial da linha [8>4>2>1:resetl:8>4>...]
	MOV 	R1, LINHA   ; volta a linha ao valor 8
	MOV 	R6, 4 		; volta o contador linha a 4
	JMP     cicloTeclado; volta ao ciclo

teclaZero:
	MOV 	R7, 0		; tecla zero
	MOVB 	[R5], R7	; guarda tecla premida em memória
	JMP fimTeclado



; ***************************
; * Movimentação
; ***************************


movimentacao:
	CALL movimentaSubmarino ; rotina de movimentação com base no teclado
	CALL movimentaBarcoUm 	; rotina de movimentação dos barco Um
	CALL movimentaBarcoDois ; rotina de movimentação dos barco Dois
	CALL movimentaBala 		; rotina de movimentação da bala
	CALL movimentaTorpedo 	; rotina de movimentação do torpedo
	RET


movimentaSubmarino:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6


	MOV R1, TECLA 	; endereço de onde está a tecla premida
	MOVB R2, [R1]	; valor da tecla premida
	MOV R7, TECLA2	; endereço da variável de controle
	MOVB R8, [R7]	; analisa o valor da variável de controle

	CMP R2, R8		; analisa se a tecla já foi premida anteriormente
	JZ fimMovimenta	; se sim, não faz nada

	MOV R3, movimentoX	; endereço da string de movimento X
	ADD R3, R2 			; avança na string para buscar o valor
	MOVB R4, [R3]		; busca na máscara o valor a ser modificado [-1,0,1]
	MOV R5, subPosX 	; endereço da coordenada X do submarino
	MOVB R6, [R5]		; pega o valor da coordenada
	ADD R4, R6			; atualiza a coordenada
	MOVB [R5], R4		; escreve na memória a coordenada nova

	MOV R3, movimentoY	; endereço da string de movimento Y
	ADD R3, R2 			; avança na string para buscar o valor
	MOVB R4, [R3]		; busca na máscara o valor a ser modificado [-1,0,1]
	MOV R5, subPosY 	; endereço da coordenada Y do submarino
	MOVB R6, [R5]		; pega o valor da coordenada
	ADD R4, R6			; atualiza a coordenada
	MOVB [R5], R4		; escreve na memória a coordenada nova

	MOVB [R7], R2		; reseta o valor da tecla premida

	fimMovimenta:	POP R6
					POP R5
					POP R4
					POP R3
					POP R2
					POP R1
					RET


movimentaBarcoUm:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5


	MOV R1, clockUm 		; endereço do clock Um
	MOVB R2, [R1]			; pega o valor do clock
	MOV R6, auxClockBarcoUm ; endereço da variável auxiliar do clock Um
	MOVB R7, [R6] 			; pega o valor da variável auxiliar
	CMP R2, R7				; compara se são iguais, se nao, movimenta
	JNZ movBarcoUm 			; movimenta o barco Um
	termMovBarcoUm:
		POP R5
		POP R4
		POP R3
		POP R2
		POP R1
		RET

	movBarcoUm:
		MOVB [R6], R2 			; atualiza valor da variável auxiliar do clock
		MOV R1, barcoUmPosX		; endereço da posição X do barco Um
		MOVB R2, [R1] 			; pega a coordenada X do barco Um
		ADD R2, 1 				; avança em uma posição
		MOV R3, 31 				; posição máxima do ecrã
		CMP R2, R3 				; compara se o barco está na posição máxima
		JZ atualizaBarcoUmY 	; muda a coordenada Y do barco
		movBarcoUm1:
			MOVB [R1], R2 			; atualiza a coordenada X do barco
			JMP termMovBarcoUm
		


		atualizaBarcoUmY:
			MOV R2, 0 				; se atingiu a borda, volta ao outro lado
			MOV R4, numAleatorio 	; endereço do número aleatório
			MOVB R5, [R4] 			; pega o valor do número aleatório
			MOV R4, barcoUmPosY 	; endereço da posição Y do barco Um
	 		MOVB [R4], R5 			; atualiza a coordenada Y com o valor do número aleatório
	 		JMP movBarcoUm1 		; volta para o ciclo


movimentaBarcoDois:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5


	MOV R1, clockUm 			; endereço do clock Um
	MOVB R2, [R1]				; pega o valor do clock
	MOV R6, auxClockBarcoDois 	; endereço da variável auxiliar do clock Um
	MOVB R7, [R6] 				; pega o valor da variável auxiliar
	CMP R2, R7					; compara se são iguais, se nao, movimenta
	JNZ movBarcoDois 			; movimenta o barco Dois
	termMovBarcoDois:
		POP R5
		POP R4
		POP R3
		POP R2
		POP R1
		RET

	movBarcoDois:
		MOVB [R6], R2 			; atualiza valor da variável auxiliar do clock
		MOV R1, barcoDoisPosX	; endereço da posição X do barco Dois
		MOVB R2, [R1] 			; pega a coordenada X do barco Dois
		ADD R2, 1 				; avança em uma posição
		MOV R3, 31 				; posição máxima do ecrã
		CMP R2, R3 				; compara se o barco está na posição máxima
		JZ atualizaBarcoDoisY 	; muda a coordenada Y do barco
		movBarcoDois1:
			MOVB [R1], R2 			; atualiza a coordenada X do barco
			JMP termMovBarcoDois
		


		atualizaBarcoDoisY:
			MOV R2, 0 				; se atingiu a borda, volta ao outro lado
			MOV R4, numAleatorio 	; endereço do número aleatório
			MOVB R5, [R4] 			; pega o valor do número aleatório
			MOV R4, barcoDoisPosY 	; endereço da posição Y do barco Um
	 		MOVB [R4], R5 			; atualiza a coordenada Y com o valor do número aleatório
	 		JMP movBarcoDois1 		; volta para o ciclo



movimentaBala:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6


	MOV R1, clockDois 		; endereço do clock Dois
	MOVB R2, [R1]			; pega o valor do clock
	MOV R6, auxClockBala 	; endereço da variável auxiliar da bala
	MOVB R7, [R6] 			; pega o valor da variável auxiliar
	CMP R2, R7				; compara se são iguais, se nao, movimenta
	JNZ movBala 			; movimenta a bala
	termMovBala:
		POP R6
		POP R5
		POP R4
		POP R3
		POP R2
		POP R1
		RET

	movBala:
		MOVB [R6], R2 			; atualiza valor da variável auxiliar do clock
		MOV R1, balaPosX		; endereço da posição X da bala
		MOVB R2, [R1] 			; pega a coordenada X da bala
		ADD R2, 1 				; avança em uma posição
		MOV R3, 31 				; posição máxima do ecrã
		CMP R2, R3 				; compara se o barco está na posição máxima
		JZ atualizaBalaY 		; muda a coordenada Y da bala
		movBala1:
			MOVB [R1], R2 			; atualiza a coordenada X da bala
			JMP termMovBala
		


		atualizaBalaY:
			MOV R2, 0 				; se atingiu a borda, volta ao outro lado
			MOV R4, numAleatorio 	; endereço do número aleatório
			MOVB R5, [R4] 			; pega o valor do número aleatório
			MOV R4, balaPosY 		; endereço da posição Y da bala
			MOV R6, 20 				; primeiro endereço possivel da bala
			ADD R6, R5 				; soma coordenada com  do número aleatório
	 		MOVB [R4], R6 			; atualiza a coordenada Y com o valor do número aleatório somada a coordenada
	 		JMP movBala1 			; volta para o ciclo



movimentaTorpedo:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7


	MOV R1, clockDois 		; endereço do clock Dois
	MOVB R2, [R1]			; pega o valor do clock
	MOV R6, auxClockTorpedo	; endereço da variável auxiliar do torpedo
	MOVB R7, [R6] 			; pega o valor da variável auxiliar
	CMP R2, R7				; compara se são iguais, se nao, movimenta
	JNZ movTorp 			; movimenta o torpedo
	termMovTorp:
		POP R7
		POP R6
		POP R5
		POP R4
		POP R3
		POP R2
		POP R1
		RET

	movTorp:
		MOVB [R6], R2 			; atualiza valor da variável auxiliar do clock

		MOV R1, auxDesTorpedo 	; endereço da variável auxiliar
		MOVB R2, [R1] 			; pega o valor da variável
		MOV R3, 1				; registo auxiliar para desenho
		AND R2, R3				; compara se é possível movimentar
		JZ 	termMovTorp			; não movimenta

		MOV R1, torpedoPosY		; endereço da posição Y do torpedo
		MOVB R2, [R1] 			; pega a coordenada Y do torpedo
		SUB R2, 1 				; avança em uma posição
		MOV R3, 0 				; posição máxima do ecrã
		CMP R2, R3 				; compara se o torpedo está na posição máxima
		JZ atualizaTorpY 		; muda a coordenada Y do torpedo
		movTorp1:
			MOVB [R1], R2 		; atualiza a coordenada Y do torpedo
			JMP termMovTorp
		

		atualizaTorpY:
			MOV R2, 31 				; posição zero X do torpedo
			MOV R4, torpedoPosX 	; endereço da coordenada X do torpedo
			MOVB [R4], R2 			; volta à coordenada zero

			MOV R2, 29 				; posição zero do torpedo
			MOV R4, torpedoPosY		; endereço da coordenada Y do torpedo
			MOVB [R4], R2 			; volta à coordenada zero

			MOV R2, auxDesTorpedo 	; variável auxiliar de desenho do torpedo
			MOV R4, 0 				; diz para não desenhar mais
			MOVB [R2], R4 			; armazena comando na memória
			JMP termMovTorp




; ***************************
; * Escrita no PixelScreen
; ***************************


desenhaScreen:
	CALL apagaPixelScreen	; rotina de limpeza do ecrã
	CALL desenhaSubmarino	; rotina de desenho do submarino
	CALL desenhaBarcoUm 	; rotina de desenho do barco Um
	CALL desenhaBarcoDois 	; rotina de desenho do barco Dois
	CALL desenhaBala 		; rotina de desenho da bala
	CALL desenhaTorpedo		; rotina de desenho do torpedo
	CALL escrevePlacar 		; ŕotina que escreve no periferico do placar
	RET


desenhaSubmarino:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9

	MOV R1, subMascara	; estrutura do submarino, contendo o desenho e o tamanho da caixa

	MOVB R2, [R1]		; armazena em R2 o tamanho X da caixa do submarino
	ADD R1, 1 			; avança na string para pegar o tamanho Y
	MOVB R3, [R1]		; armazena em R3 o tamanho Y da caixa do submarino
	ADD R1, 1			; avança na string para o começo da escrita no ecrã

	MOV R4, subPosX		; posição X do pixel de referência de escrita
	MOV R5, subPosY		; posição Y do pixel de referência de escrita

	MOV R6, 0			; variável auxiliar de controle do tamanho X da caixa
	MOV R7, 0			; variável auxiliar de controle do tamanho Y da caixa


	cicloDesenhaSubY:
		CMP R3, R7 		; analisa se é o fim da coluna
		JZ fimDesenhaSub; se for, termina

		cicloDesenhaSubX:
			CMP R2, R6			; analisa se é o fim da linha
			JZ proximaColunaSub	; avança coluna
			
			MOVB R8, [R1]		; valor 0 ou 1 da tabela
			CMP R8, 1			; caso seja 1, escreve o pixel no ecrã
			JZ auxDesPixelSub	; chama função que escreve pixel

			ADD R6, 1			; avança linha
			ADD R1, 1			; avança na tabela
			JMP cicloDesenhaSubX; volta ao ciclo

		proximaColunaSub:
			MOV R6, 0			; volta variável auxiliar x a zero
			ADD R7, 1			; próxima coluna
			JMP cicloDesenhaSubY; volta ao ciclo


	fimDesenhaSub:	POP R9
					POP R8
					POP R7
					POP R6
					POP R5
					POP R4
					POP R3
					POP R2
					POP R1
					RET
					
	auxDesPixelSub: ;essa função prepara as coordenadas
		MOVB R8, [R4]		; pega a coordenada X de referência
		MOVB R9, [R5]		; pega a coordenada Y de referência
		ADD R8, R6			; soma coordenada X com variável auxiliar X
		ADD R9, R7			; soma coordenada Y com variável auxiliar Y
		CALL desenhaPixel	; desenha o pixel no ecrã

		ADD R6, 1			; avança linha
		ADD R1, 1			; avança na tabela
		JMP cicloDesenhaSubX; volta ao ciclo



desenhaBarcoUm:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9

	MOV R1, barcoUmMascara	; estrutura do barco Um, contendo o desenho e o tamanho da caixa

	MOVB R2, [R1]		; armazena em R2 o tamanho X da caixa do barco Um
	ADD R1, 1 			; avança na string para pegar o tamanho Y
	MOVB R3, [R1]		; armazena em R3 o tamanho Y da caixa do barco Um
	ADD R1, 1			; avança na string para o começo da escrita no ecrã

	MOV R4, barcoUmPosX		; posição X do pixel de referência de escrita
	MOV R5, barcoUmPosY		; posição Y do pixel de referência de escrita

	MOV R6, 0			; variável auxiliar de controle do tamanho X da caixa
	MOV R7, 0			; variável auxiliar de controle do tamanho Y da caixa


	cicloDesenhaBarcoUmY:
		CMP R3, R7 			; analisa se é o fim da coluna
		JZ fimDesenhaBarcoUm; se for, termina

		cicloDesenhaBarcoUmX:
			CMP R2, R6			; analisa se é o fim da linha
			JZ proximaColunaBUm	; avança coluna
			
			MOVB R8, [R1]			; valor 0 ou 1 da tabela
			CMP R8, 1				; caso seja 1, escreve o pixel no ecrã
			JZ auxDesPixelBarcoUm	; chama função que escreve pixel

			ADD R6, 1				; avança linha
			ADD R1, 1				; avança na tabela
			JMP cicloDesenhaBarcoUmX; volta ao ciclo

		proximaColunaBUm:
			MOV R6, 0				; volta variável auxiliar x a zero
			ADD R7, 1				; próxima coluna
			JMP cicloDesenhaBarcoUmY; volta ao ciclo


	fimDesenhaBarcoUm:	POP R9
						POP R8
						POP R7
						POP R6
						POP R5
						POP R4
						POP R3
						POP R2
						POP R1
						RET
					
	auxDesPixelBarcoUm: ;essa função prepara as coordenadas
		MOVB R8, [R4]			; pega a coordenada X de referência
		MOVB R9, [R5]			; pega a coordenada Y de referência
		ADD R8, R6				; soma coordenada X com variável auxiliar X
		ADD R9, R7				; soma coordenada Y com variável auxiliar Y
		CALL desenhaPixel		; desenha o pixel no ecrã

		ADD R6, 1				; avança linha
		ADD R1, 1				; avança na tabela
		JMP cicloDesenhaBarcoUmX; volta ao ciclo



desenhaBarcoDois:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9

	MOV R1, barcoDoisMascara	; estrutura do barco Dois, contendo o desenho e o tamanho da caixa

	MOVB R2, [R1]		; armazena em R2 o tamanho X da caixa do barco Dois
	ADD R1, 1 			; avança na string para pegar o tamanho Y
	MOVB R3, [R1]		; armazena em R3 o tamanho Y da caixa do barco Dois
	ADD R1, 1			; avança na string para o começo da escrita no ecrã

	MOV R4, barcoDoisPosX		; posição X do pixel de referência de escrita
	MOV R5, barcoDoisPosY		; posição Y do pixel de referência de escrita

	MOV R6, 0			; variável auxiliar de controle do tamanho X da caixa
	MOV R7, 0			; variável auxiliar de controle do tamanho Y da caixa


	cicloDesenhaBarcoDoisY:
		CMP R3, R7 			; analisa se é o fim da coluna
		JZ fimDesenhaBarcoDois; se for, termina

		cicloDesenhaBarcoDoisX:
			CMP R2, R6			; analisa se é o fim da linha
			JZ proximaColunaBDois	; avança coluna
			
			MOVB R8, [R1]			; valor 0 ou 1 da tabela
			CMP R8, 1				; caso seja 1, escreve o pixel no ecrã
			JZ auxDesPixelBarcoDois	; chama função que escreve pixel

			ADD R6, 1				; avança linha
			ADD R1, 1				; avança na tabela
			JMP cicloDesenhaBarcoDoisX; volta ao ciclo

		proximaColunaBDois:
			MOV R6, 0				; volta variável auxiliar x a zero
			ADD R7, 1				; próxima coluna
			JMP cicloDesenhaBarcoDoisY; volta ao ciclo


	fimDesenhaBarcoDois:	POP R9
							POP R8
							POP R7
							POP R6
							POP R5
							POP R4
							POP R3
							POP R2
							POP R1
							RET
					
	auxDesPixelBarcoDois: ;essa função prepara as coordenadas
		MOVB R8, [R4]			; pega a coordenada X de referência
		MOVB R9, [R5]			; pega a coordenada Y de referência
		ADD R8, R6				; soma coordenada X com variável auxiliar X
		ADD R9, R7				; soma coordenada Y com variável auxiliar Y
		CALL desenhaPixel		; desenha o pixel no ecrã

		ADD R6, 1					; avança linha
		ADD R1, 1					; avança na tabela
		JMP cicloDesenhaBarcoDoisX; volta ao ciclo


desenhaBala:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9

	MOV R1, balaMascara	; estrutura da bala, contendo o desenho e o tamanho da caixa

	MOVB R2, [R1]		; armazena em R2 o tamanho X da caixa da bala
	ADD R1, 1 			; avança na string para pegar o tamanho Y
	MOVB R3, [R1]		; armazena em R3 o tamanho Y da caixa da bala
	ADD R1, 1			; avança na string para o começo da escrita no ecrã

	MOV R4, balaPosX		; posição X do pixel de referência de escrita
	MOV R5, balaPosY		; posição Y do pixel de referência de escrita

	MOV R6, 0			; variável auxiliar de controle do tamanho X da caixa
	MOV R7, 0			; variável auxiliar de controle do tamanho Y da caixa


	cicloDesenhaBalaY:
		CMP R3, R7 			; analisa se é o fim da coluna
		JZ fimDesenhaBala	; se for, termina

		cicloDesenhaBalaX:
			CMP R2, R6			; analisa se é o fim da linha
			JZ proximaColunaBala	; avança coluna
			
			MOVB R8, [R1]			; valor 0 ou 1 da tabela
			CMP R8, 1				; caso seja 1, escreve o pixel no ecrã
			JZ auxDesPixelBala		; chama função que escreve pixel

			ADD R6, 1				; avança linha
			ADD R1, 1				; avança na tabela
			JMP cicloDesenhaBalaX	; volta ao ciclo

		proximaColunaBala:
			MOV R6, 0				; volta variável auxiliar x a zero
			ADD R7, 1				; próxima coluna
			JMP cicloDesenhaBalaY	; volta ao ciclo


	fimDesenhaBala:		POP R9
						POP R8
						POP R7
						POP R6
						POP R5
						POP R4
						POP R3
						POP R2
						POP R1
						RET
					
	auxDesPixelBala: ;essa função prepara as coordenadas
		MOVB R8, [R4]			; pega a coordenada X de referência
		MOVB R9, [R5]			; pega a coordenada Y de referência
		ADD R8, R6				; soma coordenada X com variável auxiliar X
		ADD R9, R7				; soma coordenada Y com variável auxiliar Y
		CALL desenhaPixel		; desenha o pixel no ecrã

		ADD R6, 1				; avança linha
		ADD R1, 1				; avança na tabela
		JMP cicloDesenhaBalaX	; volta ao ciclo



desenhaTorpedo:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9

	MOV R1, auxDesTorpedo 	; endereço da variável auxiliar
	MOVB R2, [R1] 			; pega o valor da variável
	MOV R3, 1				; registo auxiliar para desenho
	AND R2, R3				; compara se é possível atirar
	JZ 	fimDesenhaTorpedo	; não desenha



	MOV R1, torpedoMascara	; estrutura do torpedo, contendo o desenho e o tamanho da caixa

	MOVB R2, [R1]			; armazena em R2 o tamanho X da caixa do torpedo
	ADD R1, 1 				; avança na string para pegar o tamanho Y
	MOVB R3, [R1]			; armazena em R3 o tamanho Y da caixa do torpedo
	ADD R1, 1				; avança na string para o começo da escrita no ecrã

	MOV R4, torpedoPosX		; posição X do pixel de referência de escrita
	MOV R5, torpedoPosY		; posição Y do pixel de referência de escrita

	MOV R6, 0				; variável auxiliar de controle do tamanho X da caixa
	MOV R7, 0				; variável auxiliar de controle do tamanho Y da caixa


	cicloDesenhaTorpedoY:
		CMP R3, R7 				; analisa se é o fim da coluna
		JZ fimDesenhaTorpedo	; se for, termina

		cicloDesenhaTorpedoX:
			CMP R2, R6				; analisa se é o fim da linha
			JZ proximaColunaTorpedo	; avança coluna
			
			MOVB R8, [R1]			; valor 0 ou 1 da tabela
			CMP R8, 1				; caso seja 1, escreve o pixel no ecrã
			JZ auxDesPixelTorpedo	; chama função que escreve pixel

			ADD R6, 1				; avança linha
			ADD R1, 1				; avança na tabela
			JMP cicloDesenhaTorpedoX; volta ao ciclo

		proximaColunaTorpedo:
			MOV R6, 0				; volta variável auxiliar x a zero
			ADD R7, 1				; próxima coluna
			JMP cicloDesenhaTorpedoY; volta ao ciclo


	fimDesenhaTorpedo:	POP R9
						POP R8
						POP R7
						POP R6
						POP R5
						POP R4
						POP R3
						POP R2
						POP R1
						RET
					
	auxDesPixelTorpedo: ;essa função prepara as coordenadas
		MOVB R8, [R4]			; pega a coordenada X de referência
		MOVB R9, [R5]			; pega a coordenada Y de referência
		ADD R8, R6				; soma coordenada X com variável auxiliar X
		ADD R9, R7				; soma coordenada Y com variável auxiliar Y
		CALL desenhaPixel		; desenha o pixel no ecrã

		ADD R6, 1				; avança linha
		ADD R1, 1				; avança na tabela
		JMP cicloDesenhaTorpedoX; volta ao ciclo



desenhaFim:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9

	MOV R1, fimMascara	; estrutura da bala, contendo o desenho e o tamanho da caixa

	MOVB R2, [R1]		; armazena em R2 o tamanho X da caixa do fim
	ADD R1, 1 			; avança na string para pegar o tamanho Y
	MOVB R3, [R1]		; armazena em R3 o tamanho Y da caixa do fim
	ADD R1, 1			; avança na string para o começo da escrita no ecrã

	MOV R4, fimPosX		; posição X do pixel de referência de escrita
	MOV R5, fimPosY		; posição Y do pixel de referência de escrita

	MOV R6, 0			; variável auxiliar de controle do tamanho X da caixa
	MOV R7, 0			; variável auxiliar de controle do tamanho Y da caixa


	cicloDesenhaFimY:
		CMP R3, R7 			; analisa se é o fim da coluna
		JZ fimDesenhaFim	; se for, termina

		cicloDesenhaFimX:
			CMP R2, R6			; analisa se é o fim da linha
			JZ proximaColunaFim	; avança coluna
			
			MOVB R8, [R1]			; valor 0 ou 1 da tabela
			CMP R8, 1				; caso seja 1, escreve o pixel no ecrã
			JZ auxDesPixelFim		; chama função que escreve pixel

			ADD R6, 1				; avança linha
			ADD R1, 1				; avança na tabela
			JMP cicloDesenhaFimX	; volta ao ciclo

		proximaColunaFim:
			MOV R6, 0				; volta variável auxiliar x a zero
			ADD R7, 1				; próxima coluna
			JMP cicloDesenhaFimY	; volta ao ciclo


	fimDesenhaFim:		POP R9
						POP R8
						POP R7
						POP R6
						POP R5
						POP R4
						POP R3
						POP R2
						POP R1
						RET
					
	auxDesPixelFim: ;essa função prepara as coordenadas
		MOVB R8, [R4]			; pega a coordenada X de referência
		MOVB R9, [R5]			; pega a coordenada Y de referência
		ADD R8, R6				; soma coordenada X com variável auxiliar X
		ADD R9, R7				; soma coordenada Y com variável auxiliar Y
		CALL desenhaPixel		; desenha o pixel no ecrã

		ADD R6, 1				; avança linha
		ADD R1, 1				; avança na tabela
		JMP cicloDesenhaFimX	; volta ao ciclo



desenhaPixel:  ; essa função recebe coordenadas (x,y) [0,31] e escreve o pixel
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9

 	MOV R7, 8		; auxiliar para cálculo
 	MOV R2, R8		; copia o valor de X
 	MOD R2, R7		; X mod 8, usado para escrever no pixel

	MOV R6, 0 		; endereço do pixel a se desenhar
	MOV R7, 8000H	; constante para cálculo
	ADD R6, R7		; cálculo
	SHR R8, 3 		; divide X por 8
	ADD R6, R8		; cálculo
	SHL R9, 2		; multiplica Y por 4
	ADD R6, R9 		; cálculo. Aqui temos o endereço certo

	MOV R1, mascaraPixel 	; endereço da máscara
	ADD R1, R2 				; valor da máscara a ser escrito
	MOVB R2,[R1] 			; valor que tem que ser escrito na memória
	MOVB R7,[R6] 			; valor que estava anteriormente na memória
	OR R7, R2 				; valor antigo + atual
	MOVB [R6], R7			; escrita na memória

	POP R9
	POP R8
	POP R7
	POP R6
	POP R5
	POP R3
	POP R2
	POP R1
	RET






; ***************************
; * Funções Auxiliares
; ***************************


estadoJogo:
	PUSH R1
	PUSH R2

	MOV R1, auxFim 	; endereço da variável que analisa o estado do jogo
	MOVB R2, [R1]	; pega o estado do jogo
	MOV R1, 1 		; registo auxiliar
	AND R1, R2 		; analisa estado do jogo (0 rodando, 1 parado)
	JZ jogoRodando 	; rotina normal do jogo
	JNZ jogoParado 	; rotina de fim

	fimEstadoJogo:  POP R2
					POP R1
				 	RET

	jogoRodando:
		CALL geraTorpedo 		; rotina que gera o torpedo quando tecla 6 for premida
		CALL movimentacao 		; rotina geral de movimentação dos elementos
		CALL desenhaScreen 		; rotina que desenha tudo na Pixel Screen
		CALL colisaoBala 		; rotina que analisa se houve colisão entre a bala e o submarino
		CALL colisaoTorpedo 	; rotina que analisa se houve colisão entre o torpedo e os barcos
		JMP fimEstadoJogo 		; volta ao ciclo

	jogoParado:
		CALL apagaPixelScreen	; rotina de limpeza do ecrã
		CALL desenhaFim 		; rotina de desenho do fim
		JMP fimEstadoJogo		; volta ao ciclo


apagaPixelScreen:
	PUSH R1
	PUSH R2
	PUSH R3

	MOV R1, 8000H 	; endereço inicial
	MOV R2,	8080H 	; endereço final
	MOV R3, 00H 	; máscara de pixels apagados

	cicloApaga:
		MOV [R1], R3	; apaga pixels do endereço
		CMP R1, R2 		; verifica se é o ultimo endereço
		JZ	fimApaga	; se for, termina
		ADD	R1, 0002H	; próximo endereço
		JMP	cicloApaga	; volta ao ciclo

	fimApaga:
		POP R3
		POP R2
		POP R1
		RET


clocks:
	CALL cicloClockUm
	CALL cicloClockDois
	RET



cicloClockUm:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	
	MOV R1, PKEYOUT 	; endereço do periferico do teclado, que armazena também o clock
	MOVB R2, [R1]		; ler do porto de entrada
	MOV R3, 10H 		; máscara 0001 0000, que é o bit que se encontra o clock Um
	AND R2,	R3 			; pega só o bit do clock
	MOV R4, clockUm 	; endereço do clockUm na memória
	MOVB [R4], R2 		; armazena na memória o clock

	POP R4
	POP R3
	POP R2
	POP R1
	RET


cicloClockDois:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	
	MOV R1, PKEYOUT 	; endereço do periferico do teclado, que armazena também o clock
	MOVB R2, [R1]		; ler do porto de entrada
	MOV R3, 20H 		; máscara 0010 0000, que é o bit que se encontra o clock Dois
	AND R2,	R3 			; pega só o bit do clock
	MOV R4, clockDois 	; endereço do clockUm na memória
	MOVB [R4], R2 		; armazena na memória o clock

	POP R4
	POP R3
	POP R2
	POP R1
	RET


numeroAleatorio:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5

	MOV R1, auxNumAlea 	; endereço da variável auxiliar
	MOVB R2, [R1] 		; armazena no registo o valor
	MOV R1, clockUm 	; endereço do clock Um
	MOVB R3, [R1]		; avalia o valor do clock
	MOV R4, 10H			; registo auxiliar, máscara
	AND R4, R3 			; avalia o estado do clock
	JNZ escreveNumAlea 	; escreve na memória o número aleatório

	continuaNumAlea:
		ADD R2, 1 			; avança o contador
		MOV R6, 10 			; valor máximo da variável
		CMP R6, R2 			; compara se é o valor máximo
		JZ resetaAux 		; volta o auxiliar a zero
		fimNumAlea:
			MOV R1, auxNumAlea 	; endereço da variável auxiliar 
			MOVB [R1], R2 		; escreve na memória da variável auxiliar

			POP R5
			POP R4
			POP R3
			POP R2
			POP R1
			RET

	escreveNumAlea:
 		MOV R5, numAleatorio 	; endereço do número aleatório na memória
 		MOVB [R5], R2 			; armazena na memória
 		JMP continuaNumAlea 	; volta pra função

 	resetaAux:
 		MOV R2, 0  		; volta o contador a zero
 		JMP fimNumAlea 	; volta ao ciclo


geraTorpedo:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4

	MOV R1, TECLA 		; endereço de onde está a tecla premida
	MOVB R2, [R1]		; valor da tecla premida
	MOV R3, TECLA2		; endereço da variável de controle
	MOVB R4, [R3]		; analisa o valor da variável de controle

	CMP R2, R4			; analisa se a tecla já foi premida anteriormente
	JZ fimGeraTorpedo	; se sim, não faz nada
	MOV R1, 6 			; valor do teclado que faz atirar
	CMP R2, R1  		; avalia se é para atirar
	JZ atira 			; vai para o ciclo de tiro


	fimGeraTorpedo:	POP R4
					POP R3
					POP R2
					POP R1
					RET

	atira:
		MOV R1, torpedoPosX ; endereço da posição X do torpedo
		MOVB R4, [R1]		; valor da coordenada X do torpedo
		MOV R1, 31 			; valor auxiliar/inicial da coordenada X do torpedo
		CMP R4, R1 			; compara X se é possivel atirar
		JNZ comparaTorpY 	; compara Y se é possivel atirar

		contAtira:
			MOV R1, auxDesTorpedo 	; endereço da variável auxiliar
			MOV R4, 1 				; permite desenho do torpedo
			MOVB [R1], R4			; permite desenho do torpedo

			MOV R1, subPosX    		; endereço da posição X do submarino
			MOVB R4, [R1]			; valor da coordenada X do submarino
			ADD R4, 3				; soma 4 posições a esquerda, é o centro do submarino
			MOV R1, torpedoPosX 	; endereço da posição X do torpedo
			MOVB [R1], R4 			; armazena a coordenada X do torpedo

			MOV R1, subPosY 		; endereço da posição Y do submarino
			MOVB R4, [R1]			; valor da coordenada Y do submarino
			SUB R4, 1				; subtrai 1 posição a cima, é logo em cima do submarino
			MOV R1, torpedoPosY 	; endereço da posição Y do torpedo
			MOVB [R1], R4 			; armazena a coordenada Y do torpedo

			fimGeraTorpedoA:
				MOVB [R3], R2		; reseta o valor da tecla premida
				JMP fimGeraTorpedo 	; vai ao fim da função

		comparaTorpY:
			MOV R1, torpedoPosY ; endereço da posição Y do torpedo
			MOVB R4, [R1]		; valor da coordenada Y do torpedo
			MOV R1, 29 			; valor auxiliar/inicial da coordenada Y do torpedo
			CMP R4, R1 			; compara Y se é possivel atirar
			JNZ fimGeraTorpedoA ; não atira
			JMP contAtira 		; continua atirando


analisaFim:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4

	MOV R1, TECLA 		; endereço de onde está a tecla premida
	MOVB R2, [R1]		; valor da tecla premida
	MOV R3, TECLA2		; endereço da variável de controle
	MOVB R4, [R3]		; analisa o valor da variável de controle

	CMP R2, R4			; analisa se a tecla já foi premida anteriormente
	JZ terminaFim 		; se sim, não faz nada
	MOV R1, 13 			; valor do teclado que faz terminar o jogo
	CMP R2, R1  		; avalia se é para terminar
	JZ finalJogo		; vai para o ciclo de término
	MOV R1, 12 			; valor do teclado que faz começar o jogo
	CMP R2, R1  		; avalia se é para terminar
	JZ inicioJogo		; vai para o ciclo de término


	terminaFim:		POP R4
					POP R3
					POP R2
					POP R1
					RET

	finalJogo:
		MOV R1, auxFim 		; endereço da variável auxiliar do fim do jogo
		MOV R4, 1 			; valor que indica que é o fim
		MOVB [R1], R4 		; guarda na memória que é o fim do jogo
		MOVB [R3], R2		; reseta o valor da tecla premida
		JMP terminaFim

	inicioJogo:
		CALL inicio 		; reseta o jogo
		MOV R1, auxFim 		; endereço da variável auxiliar do fim do jogo
		MOV R4, 0 			; valor que indica que é o inicio
		MOVB [R1], R4 		; guarda na memória que é o inicio do jogo
		MOVB [R3], R2		; reseta o valor da tecla premida
		JMP terminaFim


colisaoBala:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9

	MOV R1, balaPosX 	; endereço da posição X da bala
	MOVB R2, [R1] 		; pega o valor da coordenada X da bala
	MOV R1, balaPosY 	; endereço da posição Y da bala
	MOVB R3, [R1] 		; pega o valor da coordenada Y da bala

	MOV R1, subPosX 	; endereço da posição X do submarino
	MOVB R4, [R1] 		; pega o valor da coordenada X do submarino
	MOV R1, subPosY 	; endereço da posição Y do submarino
	MOVB R5, [R1] 		; pega o valor da coordenada Y do submarino
	
	MOV R6, 0 			; variável de controle X do loop de verificação
	MOV R7, 0			; variável de controle Y do loop de verificação
	MOV R8, 6 			; limite da variável de controle de verificação (tamanho X do submarino)
	MOV R9, 3			; limite da variável de controle de verificação (tamanho Y do submarino)

	
	cicloColBala:
		CMP R7, R9 			; compara se chegou no fim da variável de controle Y
		JZ fimColisaoBala 	; termina se sim			
		CMP R3, R5 			; checa se houve colisão nas coordenadas Y
		JZ cicloColBalaX 	; ciclo que checa se houve nas coordenadas X
		cicloColBala1:
			ADD R5, 1		; avança coordenada Y do submarino
			ADD R7, 1		; soma a variavel de controle
			JMP cicloColBala

		cicloColBalaX:
			CMP R6, R8 			; compara se chegou no fim da variável de controle X
			JZ cicloColBala1 	; volta pro loop se sim
			CMP R2, R4 			; checa se houve colisão nas coordenadas X
			JZ acabaJogo 		; ciclo que termina o jogo
			ADD R4, 1			; avança coordenada X do submarino
			ADD R6, 1 			; soma a variavel de controle
			JMP cicloColBalaX


		acabaJogo:
			MOV R1, auxFim 		; endereço da variável auxiliar de fim de jogo
			MOV R2, 1 			; valor que identifica que é o fim do jogo
			MOVB [R1], R2		; armazena na memória que é o fim do jogo
			JMP fimColisaoBala


	fimColisaoBala: POP R9
					POP R8
					POP R7
					POP R6
					POP R5
					POP R4
					POP R3
					POP R2
					POP R1
					RET


colisaoTorpedo:
	PUSH R1
	PUSH R2
	PUSH R3
	PUSH R4
	PUSH R5
	PUSH R6
	PUSH R7
	PUSH R8
	PUSH R9

	MOV R1, torpedoPosX ; endereço da posição X do torpedo
	MOVB R2, [R1] 		; pega o valor da coordenada X do torpedo
	MOV R1, torpedoPosY ; endereço da posição Y do torpedo
	MOVB R3, [R1] 		; pega o valor da coordenada Y do torpedo

	MOV R1, barcoUmPosX ; endereço da posição X do barco Um
	MOVB R4, [R1] 		; pega o valor da coordenada X do barco Um
	MOV R1, barcoUmPosY ; endereço da posição Y do barco Um
	MOVB R5, [R1] 		; pega o valor da coordenada Y do barco Um
	
	MOV R6, 0 			; variável de controle X do loop de verificação
	MOV R7, 0			; variável de controle Y do loop de verificação
	MOV R8, 8 			; limite da variável de controle de verificação (tamanho X do barco Um)
	MOV R9, 6			; limite da variável de controle de verificação (tamanho Y do barco Um)

	
	cicloColBarcoUm:
		CMP R7, R9 			; compara se chegou no fim da variável de controle Y
		JZ fimColisaoBarcoUm; termina se sim			
		CMP R3, R5 			; checa se houve colisão nas coordenadas Y
		JZ cicloColBarcoUmX	; ciclo que checa se houve nas coordenadas X
		cicloColBarcoUm1:
			ADD R5, 1		; avança coordenada Y do barco Um
			ADD R7, 1		; soma a variavel de controle
			JMP cicloColBarcoUm

		cicloColBarcoUmX:
			CMP R6, R8 			; compara se chegou no fim da variável de controle X
			JZ cicloColBarcoUm1 ; volta pro loop se sim
			CMP R2, R4 			; checa se houve colisão nas coordenadas X
			JZ somaPlacarUm		; ciclo que termina o jogo
			ADD R4, 1			; avança coordenada X do barco Um
			ADD R6, 1 			; soma a variavel de controle
			JMP cicloColBarcoUmX


		somaPlacarUm:
			MOV R1, scoreBoard	; endereço do placar
			MOVB R2, [R1]		; pega o valor do placar
			ADD R2, 1 			; soma 1 no placar
			MOVB [R1], R2		; armazena na memória o placar

			MOV R2, 0			; registo auxiliar
			MOV R1, barcoUmPosX ; endereço da posição X do barco Um
			MOVB [R1], R2		; coloca na posição zero
			MOV R1, barcoUmPosY ; endereço da posição Y do barco Um
			MOVB [R1], R2 		; coloca na posição zero

			JMP fimColisaoBarcoUm


	fimColisaoBarcoUm: 

		MOV R1, barcoDoisPosX 	; endereço da posição X do barco Dois
		MOVB R4, [R1] 			; pega o valor da coordenada X do barco Dois
		MOV R1, barcoDoisPosY 	; endereço da posição Y do barco Dois
		MOVB R5, [R1] 			; pega o valor da coordenada Y do barco Dois

		MOV R6, 0 			; variável de controle X do loop de verificação
		MOV R7, 0			; variável de controle Y do loop de verificação
		MOV R8, 6 			; limite da variável de controle de verificação (tamanho X do barco Dois)
		MOV R9, 5			; limite da variável de controle de verificação (tamanho Y do barco Dois)

		cicloColBarcoDois:
		CMP R7, R9 				; compara se chegou no fim da variável de controle Y
		JZ fimColisaoBarcoDois 	; termina se sim			
		CMP R3, R5 				; checa se houve colisão nas coordenadas Y
		JZ cicloColBarcoDoisX	; ciclo que checa se houve nas coordenadas X
		cicloColBarcoDois1:
			ADD R5, 1			; avança coordenada Y do barco Dois
			ADD R7, 1			; soma a variavel de controle
			JMP cicloColBarcoDois

		cicloColBarcoDoisX:
			CMP R6, R8 				; compara se chegou no fim da variável de controle X
			JZ cicloColBarcoDois1 	; volta pro loop se sim
			CMP R2, R4 				; checa se houve colisão nas coordenadas X
			JZ somaPlacarDois		; ciclo que termina o jogo
			ADD R4, 1				; avança coordenada X do barco Dois
			ADD R6, 1 				; soma a variavel de controle
			JMP cicloColBarcoDoisX


		somaPlacarDois:
			MOV R1, scoreBoard	; endereço do placar
			MOVB R2, [R1]		; pega o valor do placar
			ADD R2, 1 			; soma 1 no placar
			MOVB [R1], R2		; armazena na memória o placar

			MOV R2, 0				; registo auxiliar
			MOV R1, barcoDoisPosX	; endereço da posição X do barco Dois
			MOVB [R1], R2			; coloca na posição zero
			MOV R2, 5 				; registo auxiliar
			MOV R1, barcoDoisPosY 	; endereço da posição Y do barco Dois
			MOVB [R1], R2 			; coloca na posição cinco

			JMP fimColisaoBarcoDois


	fimColisaoBarcoDois:	POP R9
							POP R8
							POP R7
							POP R6
							POP R5
							POP R4
							POP R3
							POP R2
							POP R1
							RET

escrevePlacar:
	PUSH R1
	PUSH R2

	MOV R1, scoreBoard 	; endereço do scoreboard
	MOVB R2, [R1] 		; pega o placar do jogador
	MOV R1, PLACAR 		; endereço do periférico de placar
	MOVB [R1], R2 		; escreve no periférico

	POP R2
	POP R1
	RET
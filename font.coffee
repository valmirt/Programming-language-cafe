{
	Valmir Torres de Jesus Junior
	date: 07-07-2018

	The compiler made in Lua that receives a .coffee file
	and translates to C language.

	-Arquivo de texto que sera traduzido-
}

inicio
	varinicio
		A lit;
		B int;
		D int;
		C real;
		E int;
	varfim;

	escreva "Digite B: ";
	leia B;
	escreva "Digite A: ";
	leia A;

	se (B>2) entao
		se (B<=4) entao
			escreva "B esta entre 2 e 4";
		fimse
	fimse

	B <- B + 1;
	B <- B + 2;
	B <- B + 3;
	D <- B;
	C <- 5.0;
	E <- B;

	escreva "\nB = ";
	escreva D;
	escreva "\n";
	escreva C;
	escreva "\n";
	escreva A;
	escreva "\n";
fim

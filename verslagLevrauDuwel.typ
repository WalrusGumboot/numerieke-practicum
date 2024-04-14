#set text(lang: "nl")
#set par(justify: true)
#set page(margin: 15mm)

#show raw: set text(8pt, font: "Iosevka NF")

#show raw.where(block: true, lang: "matlab"): it => {

  let v = it.lines.enumerate().map(l => (text(str(l.at(0) + 1)), l.at(1))).flatten();

  grid(
    inset: (x: 6pt, y: 3pt), 
    fill: (col, row) => if col == 0 { luma(220) } else { luma(240) }, 
    columns: (auto, auto),
    // column-gutter: 6pt,
    ..v
  )
}

#show math.equation: it => box(it)
#show link: it => underline(text(fill: blue, it))

#align(
  center,
  rect(
    width: 100%,
    inset: (y: 2em),
    fill: blue.lighten(85%),
    stroke: black,
    radius: 6pt,
    stack(
      spacing: 8pt,
      text("Verslag bij practicum Numerieke Wiskunde", 20pt, weight: "bold"),
      text(datetime.today().display(), 14pt),
      text("Mara Levrau, Simeon Duwel", 14pt),
    )
  )
)

= Opdracht 1

*Stelling.* Zij $n in NN_0$ en zijn $A, L, U in RR^(n times n)$ matrices. Veronderstel dat $L$ onderdriehoekig is, dat $U$ bovendriehoekig is en dat $forall i in {1, ..., n}: L_(i i) = 1$. Veronderstel bovendien dat $A = L U$. Dan geldt

#{
  set math.equation(numbering: "(1)", supplement: "vergelijking")
  [$ forall i in {1, ..., n}: cases(
    U_(i k) = A_(i k) - sum_(j = 1)^(i - 1) L_(i j) U_(j k) quad & forall k in {i, ..., n},
    L_(k i) = (A_(k i) - sum_(j = 1)^(i - 1) L_(k j) U_(j i)) / U_(i i) & forall k in {i + 1, ..., n}
  ) $ <bewijslast>]
}

*Bewijs.* We gebruiken een bewijs via inductie, over de dimensie van $A$, $L$ en $U$.

*Basisstap:* $n = 1$ \
De kwantor $forall i in {1, ..., n}$ kan vereenvoudigd worden tot $i = 1$. Zo kunnen we ook $forall k in {i, ..., n}$ vereenvoudigen tot $k = 1$. Ingevuld leidt dit tot de volgende bewijslast:

$ U_(1 1) = A_(1 1) - sum_(j = 1)^(0) L_(1 j) U_(j 1) and L_(1 1) = (A_(1 1) - sum_(j = 1)^(0) L_(1 j) U_(j 1))/U_(1 1) $

We gebruiken hier de conventie dat een som die itereert van een hogere naar een lagere index gelijk is aan nul -- immers zijn er geen termen in de som, aangezien geen enkel natuurlijk getal $j$ kan voldoen aan $j >= 1 and j <= 0$. Dus rest ons te bewijzen dat $ U_(1 1) = A_(1 1) and L_(1 1) = A_(1 1)/U_(1 1). $

Gegeven dat alle diagonaalelementen van $L$ gelijk zijn aan 1, weten we dat in het bijzonder $L_(1 1) = 1$. Aangezien $A = L U$ kunnen we over het element $A_(1 1)$ zeggen dat het gelijk moet zijn aan $sum_(j = 1)^(1) L_(1 j) U_(j 1) = L_(1 1) dot.op U_(1 1)$. Omdat $L_(1 1) = 1$, geldt $U_(1 1) = A_(1 1)$. Dus is ook $L_(1 1) = A_(1 1)/U_(1 1)$. Hiermee is de basisstap aangetoond.

*Inductiestap:* als @bewijslast geldt voor $n$, dan geldt ze ook voor $n + 1$. \
Zij $A in RR^((n + 1) times (n + 1))$ de matrix waarvoor we de bewijslast willen aantonen, en zij $A' in RR^(n times n) := A[1, 2, ..., n; 1, 2, ..., n]$ de submatrix van $A$ waarvoor @bewijslast al geldt. Zijn tenslotte $L$ en $U$ twee matrices met dezelfde afmetingen als $A$, met $L$ eenheidsonderdriehoekig en $U$ bovendriehoekig en $L U = A$.

Merk op dat we de propositie alleen nog moeten aantonen voor $i = n + 1$. Immers, wegens de inductiehypothese geldt de uitspraak al $forall i in {1, ..., n}$; slechts over de 'buitenste schil' bestaat nog onzekerheid. Bovendien moet enkel van de meest rechtse kolom van $U$ en onderste rij van $L$ nog getoond worden dat hun elementen aan de gevraagde eigenschap voldoen. Van de elementen $U[n+1; 1, ..., n]$ weten we immers dat ze nul zijn wegens het gegeven, en net zo voor $L[1, ..., n; n + 1]$.

Te bewijzen is dus: $ forall i in {1, ..., n + 1} : U_(i, n+1) = A_(i, n + 1) - sum_(j = 1)^(i - 1) L_(i, j) U_(j, n+1) $
en tevens: $ forall i in {1, ..., n + 1} : L_(n+1, i) = (A_(n + 1, i) - sum_(j = 1)^(i - 1) L_(n+1, j) U_(j, i))/U_(i i) $

We tonen de eerste deelbewijslast aan door een willekeurige $i in {1, ..., n + 1}$ te kiezen.
Bemerk dat we $A_(i, n + 1)$ kunnen schrijven als $(L U)_(i, n+1) = sum_(j = 1)^(n + 1) L_(i, j) U_(j, n+1)$, en bemerk bovendien dat de term van de som $0$ wordt wanneer $i < j$; dan is $L_(i, j)$ immers gelijk aan nul. Dus kunnen we de som herschrijven als $sum_(j = 1)^(i) L_(i, j) U_(j, n+1)$. Wanneer $i = j$ geldt bovendien dat $L_(i, j) = L_(i, i) = 1$, waardoor we die index af kunnen scheiden om te bekomen dat $sum_(j = 1)^(i) L_(i, j) U_(j, n+1) = U_(i, n+1) +  sum_(j = 1)^(i - 1) L_(i, j) U_(j, n+1)$.

Dus weten we dat $A_(i, n + 1) = U_(i, n+1) + sum_(j = 1)^(i - 1) L_(i, j) U_(j, n+1)$. Dit vormen we om naar $U$ om
$U_(i, n + 1) = A_(i, n + 1) - sum_(j = 1)^(i - 1) L_(i, j) U_(j, n+1)$ te bekomen. Aangezien $i$ willekeurig gekozen was, is de gelijkheid aangetoond.

We tonen de tweede deelbewijslast aan door opnieuw een willekeurige $i in {1, ..., n + 1}$ te kiezen. Bemerk dat
$A_(n + 1, i)$ gelijk is aan $(L U)_(n + 1, i) = sum_(j = 1)^(n + 1) L_(n + 1, j) U_(j, i)$. Hier kunnen we alle indices
$j > i$ negeren, aangezien $U_(j, i)$ dan nul is. We splitsen dan weer één element uit de som af om te bekomen dat
$A_(n + 1, i) = L_(n + 1, i) dot.op U_(i, i) + sum_(j = 1)^(i - 1) L_(n + 1, j) U_(j, i)$. Dit kunnen we weer omvormen tot
$L_(n + 1, i) dot.op U_(i, i) = A_(n + 1, i) - sum_(j = 1)^(i - 1) L_(n + 1, j) U_(j, i)$, en na deling door $U_(i, i)$
in beide leden is de gelijkheid aangetoond.

Dus geldt de eigenschap ook voor $n + 1$.

Via het inductieve principe weten we nu dat de eigenschap geldt voor alle $n in NN_0$. Hiermee is de volledige stelling
aangetoond. $qed$

= Opdracht 3

NB. Per de #link("https://nl.mathworks.com/help/matlab/ref/ismembertol.html", "MATLAB-documentatie") gebruiken we de standaardtolerantiewaarde van $10^(-12)$ bij het testen of de verwachte decompositie en berekende decompositie gelijk zijn. We gebruiken hiervoor de functie `ismembertol`. In de praktijk is de echte afwijking meestal een paar grootteordes kleiner.

= Opdracht 4

Waar algoritme 5.1 een indexvariabele `k` gebruikt die van `n` tot `1` loopt, gebruiken we in de voorwaartse substitutie een variabele die van `1` tot `n` loopt, aangezien we bij de eerste rij beginnen.
Verder is het idee achter de oplossingsmethode identiek: omdat de matrices driehoekig kunnen we de rijen op zo'n manier doorlopen dat elke volgende rij extra informatie geeft over één variabele van het stelsel. We nemen dan een lineaire combinatie van de al gekende waarden om die nieuwe variabele te 'isoleren'. Na een deling door het resterende element bekomen we de correcte waarde voor de variabele.

= Opdracht 5

De correctheid wordt hier niet formeel bewezen, maar aan de hand van een zgh. _nothing up my sleeve_-test case#footnote[hier is $U$ de getallen van één tot zes, $b_1$ de eerste drie kwadraten, $L$ de rij van Fibonacci en $b_2$ de eerste drie cijfers van $pi$] gemotiveerd.

De kern van `solve_Lb` bestaat uit de volgende drie regels:

```matlab
for k = 1:n
    y(k) = (b(k) - L(k, 1:k) * y(1:k)) / L(k, k);
end
```

welke we splitsen in 

```matlab
for k = 1:n
    y(k) = b(k);
    y(k) = y(k) - L(k, 1:k) * y(1:k); % 1 aftrekking, k verm., k - 1 opt.
    y(k) = y(k) / L(k, k);            % 1 deling
end
```

In totaal levert ons dit $sum_(k = 1)^(n) (2k + 1) = n^2$ bewerkingen voor $L in RR^(n times n)$.

Voor `solve_Ub` gaan we analoog te werk:

```matlab
for k = n:-1:1
    y(k) = (b(k) - U(k, k+1:n) * y(k+1:n)) / U(k, k);
end
```

wordt

```matlab
for k = n:-1:1
    y(k) = b(k);
    y(k) = y(k) - U(k, k+1:n) * y(k+1:n); % 1 aftrekking, n - k verm., n - k + 1 opt.
    y(k) = y(k) / U(k, k);                % 1 deling
end
```

Zo bekomen we $sum_(k = 1)^(n) (1 + 2(n - k)) = n^2 + n$ bewerkingen voor $U in RR^(n times n)$.

= Opdracht 6

#rect(
  ```
  L_1 =

    1.000000000000000                   0                   0                   0                   0
    0.009090909090909   1.000000000000000                   0                   0                   0
    0.009090909090909  -0.000082651458798   1.000000000000000                   0                   0
    0.009090909090909  -0.000082651458798  -0.000082658290627   1.000000000000000                   0
    0.009090909090909  -0.000082651458798  -0.000082658290627  -0.000082665123584   1.000000000000000



  U_1 =

    1.100000000000000   0.010000000000000   0.010000000000000   0.010000000000000   0.010000000000000
                    0   1.099909090909091  -0.000090909090909  -0.000090909090909  -0.000090909090909
                    0                   0   1.099909083395322  -0.000090916604678  -0.000090916604678
                    0                   0                   0   1.099909075880311  -0.000090924119689
                    0                   0                   0                   0   1.099909068364057



  L_2 =

    1.000000000000000                   0                   0                   0                   0
                    0   1.000000000000000                   0                   0                   0
                    0                   0   1.000000000000000                   0                   0
                    0                   0                   0   1.000000000000000                   0
    0.009090909090909   0.009090909090909   0.009090909090909   0.009090909090909   1.000000000000000



  U_2 =

    1.100000000000000                   0                   0                   0   0.010000000000000
                    0   1.100000000000000                   0                   0   0.010000000000000
                    0                   0   1.100000000000000                   0   0.010000000000000
                    0                   0                   0   1.100000000000000   0.010000000000000
                    0                   0                   0                   0   1.099636363636364
  ```
)

$L_1$ en $U_1$ bevatten ieder tien nullen ($ = 2n$) en is dus niet per se spaars te noemen. \
$L_2$ en $U_2$ bevatten ieder zestien nullen ($ = (n - 1)(n - 2) + (n - 1) = (n - 1)^2$) en is dus volgens de conventie
spaars te noemen.
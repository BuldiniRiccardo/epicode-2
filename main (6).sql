-- creazione della tabella Vendite
CREATE TABLE Vendite (
    Id_transazione INTEGER PRIMARY KEY,
    Categoria_prodotto VARCHAR (50),
    Costo_vendita DECIMAL (10,2),
    Sconto_applicato DECIMAL (10,2)
);

INSERT INTO Vendite (Id_transazione, Categoria_prodotto, Costo_vendita, Sconto_applicato) VALUES
    (1, 'Elettronica', 500.00, 50.00),
    (2, 'Abbigliamento', 120.50, 61.25),
    (3, 'Gioielli', 800.75, 75.50), 
    (4, 'Cibo', 75.25, 45.00),
    (5, 'Libri', 35.99, 2.50),
    (6, 'Sport', 200.00, 20.00),
    (7, 'Arredamento', 450.50, 230.75),
    (8, 'Cosmetici', 90.75, 8.00),
    (9, 'Automobili', 25000.00, 2000.00),
    (10, 'Giocattoli', 40.25, 3.50),
    (11, 'Ferramenta', 120.00, 15.00),
    (12, 'Cucina', 75.80, 8.50),
    (13, 'Telefonia', 400.50, 40.00),
    (14, 'Orologi', 1200.75, 100.50),
    (15, 'Calzature', 55.99, 4.50),
    (16, 'Fitness', 300.00, 30.00),
    (17, 'Musica', 20.50, 12.75),
    (18, 'Outdoor', 180.75, 20.00),
    (19, 'Fotografia', 1500.00, 120.00),
    (20, 'Hobby', 50.25, 5.50),
    (21, 'Vini e Bevande', 120.75, 15.50),
    (22, 'Computer', 1200.00, 100.00),
    (23, 'Hobby creativi', 15.99, 1.25),
    (24, 'Cura personale', 45.00, 5.00),
    (25, 'Strumenti musicali', 300.25, 25.50),
    (26, 'Casa e giardino', 180.00, 15.75),
    (27, 'Film e TV', 40.75, 3.50),
    (28, 'Animali domestici', 80.50, 7.25),
    (29, 'Giardino', 200.00, 15.00),
    (30, 'Scarpe', 65.99, 36.50);


CREATE TABLE Dettagli_vendite (
    Id_transazione INTEGER PRIMARY KEY,
    Data_acquisto DATE,
    Quantita_acquistata INT
);

INSERT INTO Dettagli_vendite (Id_transazione, Data_acquisto, Quantita_acquistata) VALUES
    (1, '2023-12-21', 6),
    (2, '2023-12-21', 1),
    (3, '2024-01-03', 3),
    (4, '2024-01-03', 2),
    (5, '2023-07-03', 7),
    (6, '2024-01-06', 20),
    (7, '2024-01-06', 9),
    (8, '2024-01-08', 18),
    (9, '2023-05-26', 15),
    (10, '2023-01-02', 28),
    (11, '2024-01-01', 39),
    (12, '2024-01-05', 21),
    (13, '2024-02-03', 10),
    (14, '2024-01-04', 41),
    (15, '2023-12-25', 20),
    (16, '2023-12-26', 10),
    (17, '2023-01-07', 3),
    (18, '2023-01-08', 8),
    (19, '2024-01-09', 4),
    (20, '2023-04-10', 77),
    (21, '2024-01-11', 11),
    (22, '2024-01-12', 31),
    (23, '2024-01-13', 24),
    (24, '2024-01-04', 4),
    (25, '2024-01-05', 19),
    (26, '2023-05-26', 21),
    (27, '2024-01-07', 30),
    (28, '2023-01-08', 15),
    (29, '2023-01-08', 29),
    (30, '2023-10-21', 33);


#DOMANDA 4
#Calcolo il totale delle vendite(costo)
SELECT Categoria_prodotto, SUM(Costo_vendita) AS Totale_Vendite
FROM Vendite
GROUP BY Categoria_prodotto;

#numero totale di prodotti venduti per ogni categoria
SELECT Categoria_prodotto, SUM(Quantita_acquistata) AS Totale_Prodotti_Venduti
FROM Dettagli_vendite
JOIN Vendite ON Dettagli_vendite.Id_transazione = Vendite.Id_transazione
GROUP BY Categoria_prodotto;


#DOMANDA 5
#Seleziono le vendite dell'ultimo trimestre
SELECT * 
FROM Vendite
WHERE DATE_FORMAT(Data_acquisto,'%Y-%m-%d') BETWEEN DATE_FORMAT(NOW() - INTERVAL 3 MONTH, '%Y-%m-%d') AND DATE_FORMAT(NOW(), '%Y-%m-%d');

#Raggruppo le vendite per mese e calcolo il totale delle vendite per ogni mese
SELECT
    DATE_FORMAT(Data_acquisto, '%Y-%m') AS Mese,
    SUM(Costo_vendita) AS Totale_Vendite
FROM
    Vendite
GROUP BY
    DATE_FORMAT(Data_acquisto, '%Y-%m');


#DOMANDA 6
#Trovo la categoria con lo sconto medio più alto
SELECT Categoria_prodotto, AVG(Sconto_applicato) AS ScontoMedio
FROM Vendite
GROUP BY Categoria_prodotto
ORDER BY ScontoMedio DESC
LIMIT 1;


#DOMANDA 7
#Confronto le vendite mese per mese per vedere l'incremento o il decremento delle vendite e calcolo l’incremento o decremento mese per mese
WITH VenditeMensili AS (
    SELECT
        DATE_FORMAT(Data_acquisto, '%Y-%m') AS Mese,
        SUM(Costo_vendita) AS TotaleVendite
    FROM
        Vendite
    GROUP BY
        DATE_FORMAT(Data_acquisto, '%Y-%m')
)
SELECT
    Mese,
    TotaleVendite,
    LAG(TotaleVendite) OVER (ORDER BY Mese) AS VenditeMesePrecedente,
    COALESCE(TotaleVendite - LAG(TotaleVendite) OVER (ORDER BY Mese), 0) AS IncrementoDecremento
FROM
    VenditeMensili;























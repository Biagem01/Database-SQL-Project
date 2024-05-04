CREATE DATABASE ProgettoDB;
USE ProgettoDB;

CREATE TABLE Promotore (
IDPromotore INT AUTO_INCREMENT PRIMARY KEY,
Nome VARCHAR(50),
Cognome VARCHAR(50),
Telefono VARCHAR (20)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO Promotore (Nome, Cognome, Telefono)
VALUES ('Mario','Rossi','3316578430'),
('Giovanni','Bianchi','3336575470'),
('Gianluca','Verdi','3426556432'),
('Rosario','Amelia','3366778493'),
('Matteo','Russo','3387874420'),
('Carlo','Verde','33136547897');



CREATE TABLE Luogo (
IDLuogo INT AUTO_INCREMENT PRIMARY KEY,
NomeLuogo VARCHAR(50),
Indirizzo VARCHAR(50),
Stato VARCHAR (20),
Città VARCHAR (20),
Provincia VARCHAR (20),
Capacità_massima INT 
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO Luogo (NomeLuogo,Indirizzo,Stato,Città,Provincia,Capacità_massima) VALUES
('Teatro dell opera','Via Mercalli 1','Italia', 'Mantova', 'MN', '10000'),
('Arena di verona','Viale europa 23','Italia', 'Ragusa', 'RG', '5000'),
('Teatro Comunale','Viale Volta 101','Italia', 'Potenza','PZ', '20000'),
('Galleria D arte moderrna','Via Biagio Bini 3','Italia', 'Comiso', 'RG', '10000'),
('Stadio San Siro','Via Roma','Italia', 'Vittoria', 'RG', '5500'),
('Teatro di San Carlo','Viale vittorio Veneto','Italia', 'Catania', 'CT', '12000'),
('Auditorium della Musica','Via Martiri 589','Italia', 'Trento', 'TN', '10000'),
('Olimpico','Viale Fiorito 18','Italia', 'Roma', 'RM', '20000'),
('Auditorium parco della musica','Via Firenze 18','Italia', 'Catania', 'CT', '13000');



CREATE TABLE Artista (
IDArtista INT AUTO_INCREMENT PRIMARY KEY,
NomeArtista VARCHAR(20),
Genere VARCHAR (20),
Biografia TEXT
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



INSERT INTO Artista (NomeArtista,Genere,Biografia)  VALUES 
( 'Jhon Doe', 'Rock', 'John Doe è un cantante e chitarrista famoso nel genere rock.'),
( 'Alice Smith', 'Pop', 'Alice Smith è una cantante pop con una voce potente.'),
( 'Micheal Jhonson ', 'R&B', 'Michael Johnson è un artista R&B noto per le sue ballate romantiche.'),
( 'Emily Parker', 'Commedia', 'Emily Parker è una comica brillante con uno stile di umorismo unico.'),
( 'Laura Davis', 'Fotografia', 'Laura Davis è una fotografa professionista specializzata in ritratti e paesaggi.'),
( 'Sara Lopez', 'Danza', 'Sara Lopez è una ballerina di danza contemporanea con una tecnica eccezionale.'),
( 'Alex Turner', 'Danza', 'Alex Turner è una ballerino di danza contemporanea con una tecnica eccezionale.'),
( 'Daniel wilson', 'Soul', 'Daniel Wilson è un cantante soul con una voce calda e avvolgente.');






CREATE TABLE Evento  (
IDEvento INT AUTO_INCREMENT PRIMARY KEY,
Data DATE, 
Ora_inizio TIME,
Ora_fine TIME,
Descrizione VARCHAR (200),
Tipo VARCHAR(50),
Quantità_disponibile_biglietto INT,
id_promotore INT,
id_luogo INT,
FOREIGN KEY (id_promotore) REFERENCES Promotore(IDPromotore) ON DELETE RESTRICT ON UPDATE CASCADE,
FOREIGN KEY (id_luogo) REFERENCES Luogo(IDLuogo)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



-- Trigger per impostare la quantità disponibile sulla capacità massima del luogo
DELIMITER //

CREATE TRIGGER Set_event_quantity 
BEFORE INSERT ON Evento 
FOR EACH ROW
BEGIN
    DECLARE venue_capacity INT;
    
    -- Ottieni la capacità massima del luogo associato all'evento
    SELECT Capacità_massima INTO venue_capacity
    FROM Luogo
    WHERE IDLuogo = NEW.id_luogo;
    
    -- Imposta la quantità disponibile sulla capacità massima del luogo
    SET NEW.quantità_disponibile_biglietto = venue_capacity;
END //

DELIMITER ;


INSERT INTO Evento (Data,Ora_inizio, Ora_fine, Descrizione, Tipo,id_promotore,id_luogo) VALUES
('2023-05-18','14:00', '16:00', 'Concerto live di Daniel wilson', 'Musica','2','2'),
('2023-06-22','15:00', '18:00', 'Concerto live di Micheal Jhonson', 'Musica','2','5'),
('2023-02-02','10:00', '13:00', 'Spettacolo di danza di Sara Lopez', 'Danza','1','1'),
('2023-03-30','16:00', '17:00', 'Concerto live di Laura Davis', 'Musica','2','8'),
('2023-04-06','21:00', '23:00' , 'Serata comica con Emily Parker', 'Commedia',3,'3'),
('2024-05-16','17:00','19:00','Mostra di fotografia di Laura Davis', 'Fotografia','4','3'),
('2024-07-18','22:00','23:00','Spettacolo di danza di Alex Turner', 'Danza','2','6'),
('2023-03-26','19:00','21:00','Concerto live di Alice Smith','Musica','3','2');








CREATE TABLE PartecipaArtista (
id_artista INT,
id_evento INT,
FOREIGN KEY (id_artista) REFERENCES Artista(IDArtista),
FOREIGN KEY (id_evento) REFERENCES Evento(IDEvento)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO PartecipaArtista (id_artista,id_evento) VALUES
('8','1'),
('3','2'),
('6','3'),
('5','4'),
('4','5'),
('5','6'),
('7','7'),
('2','8'),
('3','8'),
('2','8');



CREATE TABLE Cliente (
IDCliente INT AUTO_INCREMENT PRIMARY KEY,
Nome VARCHAR(20),
Cognome VARCHAR(20),
Sesso VARCHAR (10),
Data_nascita DATE, 
Indirizzo VARCHAR (20)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO Cliente (Nome,Cognome,Sesso,Data_nascita,Indirizzo) VALUES
('Mario', 'Rossi', 'M', '1990-05-10', 'Via Roma 123'),
('Laura', 'Verdi', 'F', '1985-06-18', 'Via Milano 456'),
('Giulia', 'Bianchi', 'F', '1998-08-26', 'Via Firenze 321'),
('Marco', 'Gallo', 'M', '1993-02-07', 'Via Venezia 654'),
('Simone', 'Esposito', 'M', '1997-01-10', 'Via Palermo 123'),
('Alessandro', 'Romano', 'M', '1996-06-20', 'Via Torino 876'),
('Martina', 'Martini', 'F', '1986-04-12', 'Via Verona 3'),
('Chiara', 'Conti', 'F', '1995-04-27', 'Via Genova 987'),
('Francesca', 'Ferrari', 'F', '1997-08-08', 'Via Bologna 567'),
('Luca', 'Bianchi', 'M', '1993-02-22', 'Via Napoli 789');

CREATE TABLE Biglietto (
IDBiglietto INT AUTO_INCREMENT PRIMARY KEY,
Tipo_biglietto VARCHAR(50),
Descrizione VARCHAR (100),
Prezzo DECIMAL (5,2),
Quantità INT,
id_evento INT,
id_cliente INT,
FOREIGN KEY (id_evento) REFERENCES Evento(IDEvento),
FOREIGN KEY (id_cliente) REFERENCES Cliente (IDCliente)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


/* TRIGGER che calcola il prezzo del biglietto in base all'attributo Tipo_biglietto*/
DELIMITER //

CREATE TRIGGER Set_ticket_price BEFORE INSERT ON Biglietto FOR EACH ROW
BEGIN
    DECLARE ticket_price ;
    
    -- Imposta il prezzo del biglietto in base al tipo
    IF NEW.Tipo_biglietto = 'VIP' THEN
        SET ticket_price = 50.00;
    ELSEIF NEW.Tipo_biglietto = 'Standard' THEN
        SET ticket_price = 30.00;
    ELSEIF NEW.Tipo_biglietto = 'Ridotto' THEN
        SET ticket_price = 20.00;
    ELSE
        -- Tipo non valido, imposta il prezzo a 0.00 (valore di default)
        SET ticket_price = 0.00;
    END IF;
    
    -- Assegna il prezzo al nuovo biglietto
    SET NEW.Prezzo = ticket_price;
END //

DELIMITER ;

/* Trigger che decrementa la quantità disponibile dell'evento associato al biglietto */
DELIMITER //
CREATE TRIGGER Decrease_ticket_quantity 
AFTER INSERT ON Biglietto 
FOR EACH ROW
BEGIN

    -- Decrementa la quantità disponibile dell'evento associato al biglietto
    UPDATE Evento
    SET quantità_disponibile_biglietto = quantità_disponibile_biglietto - NEW.Quantità
    WHERE IDEvento = NEW.id_evento;
END //

DELIMITER ;

INSERT INTO Biglietto(Tipo_biglietto,Descrizione,Quantità,id_evento,id_cliente) VALUES
('VIP','Accesso privilegiato e posti riservati','2','3','1'),
('Standard','Ingresso generale','2','3','2'),
('Standard','Ingresso generale','4','3','2'),
('VIP','Accesso privilegiato e posti riservati','1','7','2'),
('Ridotto','Prezzo scontato per studenti','2','2','5'),
('VIP','Accesso privilegiato e posti riservati','4','3','2'),
('Ridotto','Accesso privilegiato e posti riservati','2','6','4'),
('Standard','Ingresso generale','1','8','5'),
('VIP','Accesso privilegiato e posti riservati','3','3','3'),
('VIP','Accesso privilegiato e posti riservati','2','5','2'),
('Ridotto','Prezzo scontato per studenti','5','5','4');




/* Stampare tutti gli eventi*/

SELECT *
FROM Evento;


/*Ottenere il promotore che ha organizzato il maggior numero di eventi */

SELECT p.IDPromotore,p.Nome,P.Cognome, COUNT(e.IDEvento) as NumeroEventiPromossi
FROM Promotore p 
JOIN Evento e ON p.IDPromotore=e.id_promotore
GROUP BY p.IDPromotore,p.Nome,P.cognome
ORDER BY NumeroEventiPromossi DESC;

/*Ottenere gli artisti che partecipano a più di un evento */

CREATE VIEW ArtistiConNumeroEventi  AS
SELECT a.NomeArtista, a.IDArtista, COUNT(pa.id_evento) as NumeroEventiPartecipati
FROM Artista a JOIN PartecipaArtista pa ON a.IDArtista=pa.id_artista
GROUP BY a.IDArtista,a.NomeArtista; 

SELECT *
FROM ArtistiConNumeroEventi 
WHERE NumeroEventiPartecipati >1;


/*Ottenere le spese totali dei clienti  */

CREATE VIEW SpeseTotaliClienti AS 
SELECT SUM(b.Prezzo * b.Quantità) AS SpesaTotale,SUM(b.quantità)AS BigliettiTotali,b.id_cliente, c.Nome,c.Cognome
FROM Biglietto b JOIN Cliente c 
ON b.id_cliente=c.IDCliente
GROUP BY  b.id_cliente,c.Nome,c.Cognome
ORDER BY SpesaTotale DESC;

SELECT *
FROM SpeseTotaliClienti;

/*Ottenere il numero di biglietti venduti per ciascun evento  */

SELECT e.IDEvento, e.Descrizione,e.Quantità_disponibile_biglietto, SUM(b.Quantità) AS Numero_Biglietti_Venduti,
  SUM(CASE WHEN b.Tipo_biglietto = 'VIP' THEN b.Quantità ELSE 0 END) AS Numero_Biglietti_VIP,
  SUM(CASE WHEN b.Tipo_biglietto = 'Standard' THEN b.Quantità ELSE 0 END) AS Numero_Biglietti_Standard,
  SUM(CASE WHEN b.Tipo_biglietto = 'Ridotto' THEN b.Quantità ELSE 0 END) AS Numero_Biglietti_Ridotti
FROM Evento e
JOIN Biglietto b ON b.id_evento = e.IDEvento
GROUP BY e.IDEvento, e.Descrizione,e.Quantità_disponibile_biglietto ;

/*Ottenere gli artisti che partecipano a eventi con capacità massima superiore alla media*/

SELECT a.IDArtista,a.NomeArtista
FROM Artista a JOIN PartecipaArtista pa ON a.IDArtista=pa.id_artista 
 JOIN Evento e ON pa.id_evento=e.IDEvento
  JOIN Luogo l ON e.id_luogo=l.IDLuogo 
WHERE l.Capacità_massima > (SELECT AVG(l.Capacità_massima)
                             FROM Luogo l);
     

                             











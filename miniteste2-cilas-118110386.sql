CREATE TABLE usuarios (
    idUser   SERIAL      PRIMARY KEY, 
    nickName VARCHAR(15) NOT NULL,
    dataNasc DATE        NOT NULL
);

CREATE TABLE musicas (
    idMusica   SERIAL      PRIMARY KEY, 
    titulo     TEXT        NOT NULL,
    estilo     CHAR(1)     NOT NULL
    CONSTRAINT estilosDeMusica CHECK (estilo IN ('R','P','E','S','A','C'))
);


CREATE TABLE avaliacoes (
    idAvaliador   SERIAL      REFERENCES  usuarios(idUser),
    idAvaliacao   SERIAL      PRIMARY KEY, 
    nota          INTEGER     NOT NULL,
    dataAvalicao  DATE,
    CONSTRAINT notaEntre0e5 CHECK (nota >= 0 AND nota <= 5)

);

CREATE TABLE perfisUsuarios (
    idPerfil   SERIAL       UNIQUE REFERENCES usuarios(idUser), 
    descr_perfil            TEXT        NOT NULL,
    cadastra_usuario        BOOLEAN     NOT NULL,
    cadastra_musica         BOOLEAN     NOT NULL,
    faz_avaliacao           BOOLEAN     NOT NULL
);


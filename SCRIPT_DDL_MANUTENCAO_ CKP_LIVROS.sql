
    -- CHECKPOINT 1 
    -- ALUNA: SAMARA VICTORIA FERRAZ DOS SANTOS 
    -- RM: 558719

DROP TABLE t_ckp_categoria CASCADE CONSTRAINTS;

DROP TABLE t_ckp_livro CASCADE CONSTRAINTS;

DROP TABLE t_ckp_autor_livro CASCADE CONSTRAINTS;

DROP TABLE t_ckp_autor CASCADE CONSTRAINTS;

CREATE TABLE t_ckp_categoria (
    cd_categoria  NUMBER(3) NOT NULL,
    ds_sigla_categoria  CHAR(3) NOT NULL,
    ds_categoria  VARCHAR2(30) NOT NULL
);

ALTER TABLE t_ckp_categoria ADD CONSTRAINT pk_ckp_categoria PRIMARY KEY ( cd_categoria );
ALTER TABLE t_ckp_categoria ADD CONSTRAINT un_ckp_categoria_sigla UNIQUE (ds_sigla_categoria);
ALTER TABLE t_ckp_categoria ADD CONSTRAINT un_ckp_categoria_desc UNIQUE (ds_categoria);

CREATE TABLE t_ckp_livro (
    nr_isbn  NUMBER(8) NOT NULL,
    cd_categoria  NUMBER(3) NOT NULL,
    nm_titulo  VARCHAR2(50) NOT NULL,
    ds_sinopse VARCHAR2(200) NOT NULL,
    nr_edicao NUMBER(2) NOT NULL,
    nr_ano NUMBER(4) NOT NULL
);

ALTER TABLE t_ckp_livro ADD CONSTRAINT pk_ckp_livro PRIMARY KEY ( nr_isbn );
ALTER TABLE t_ckp_livro ADD CONSTRAINT fk_ckp_livro_categoria FOREIGN KEY ( cd_categoria ) REFERENCES t_ckp_categoria(cd_categoria);
ALTER TABLE t_ckp_livro ADD CONSTRAINT ck_ckp_livro_edicao CHECK (nr_edicao > 0);
ALTER TABLE t_ckp_livro ADD CONSTRAINT ck_ckp_livro_livro_ano CHECK (nr_ano > 0);

CREATE TABLE t_ckp_autor_livro (
    nr_isbn  NUMBER(8) NOT NULL,
    cd_autor  NUMBER(3) NOT NULL,
    st_autor_principal  NUMBER(1) NOT NULL
);

ALTER TABLE t_ckp_autor_livro ADD CONSTRAINT pk_ckp_autor_livro PRIMARY KEY ( nr_isbn,cd_autor );
ALTER TABLE t_ckp_autor_livro ADD CONSTRAINT fk_ckp_autor_livro FOREIGN KEY ( nr_isbn ) REFERENCES t_ckp_livro(nr_isbn);
ALTER TABLE t_ckp_autor_livro ADD CONSTRAINT fk_ckp_autor_livro_autor FOREIGN KEY ( cd_autor ) REFERENCES t_ckp_autor(cd_autor);
ALTER TABLE t_ckp_autor_livro ADD CONSTRAINT ck_ckp_autor_livro_status CHECK (st_autor_principal in (1,2));

CREATE TABLE t_ckp_autor(
    cd_autor  NUMBER(3) NOT NULL,
    nm_primeiro_autor  VARCHAR2(20) NOT NULL,
    nm_segundo_autor VARCHAR2(40) NOT NULL
);

ALTER TABLE t_ckp_autor ADD CONSTRAINT pk_ckp_autor PRIMARY KEY ( cd_autor );

    -- CHECKPOINT 1: 
    -- 1. Na tabela “T_CKPn_CATEGORIA”, crie a instrução SQL, comando DDL para alterar o nome da coluna “ds_sigla_categoria” para “ds_sigla_categ”.

ALTER TABLE t_ckp_categoria RENAME COLUMN ds_sigla_categoria TO ds_sigla_categ; 
DESC t_ckp_categoria;

    -- 2.Na tabela “T_CKP_CATEGORIA”, crie a instrução SQL, comando DDL para alterar o nome da UNIQUE constraint “UN_CKP_CATEGORIA_DESC” para “UN_CKP_CATEG_DESC”. 

ALTER TABLE T_CKP_CATEGORIA DROP CONSTRAINT UN_CKP_CATEGORIA_DESC;
ALTER TABLE T_CKP_CATEGORIA ADD CONSTRAINT UN_CKP_CATEG_DESC UNIQUE (DS_CATEGORIA);

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'T_CKP_CATEGORIA'

    -- 3.  Na tabela “T_CKP_AUTOR”, crie a instrução SQL, comando DDL para alterar o tamanho da coluna “nm_segundo_autor” para 30 caracteres.
    
// (FALHA DE SISTEMA) ALTER TABLE t_ckp_autor MODIFY nm_segundo_autor VARCHAR2 (30); 
DESC t_ckp_autor;

ALTER TABLE t_ckp_autor MODIFY nm_segundo_autor VARCHAR2 (30); 
DESC t_ckp_autor; 

    -- 4. Na tabela “T_CKP_AUTOR”, crie a instrução SQL, comando DDL para adicionar coluna “ds_email”, com tipo de dado VARCHAR2, tamanho 40 caracteres e obrigatória.

ALTER TABLE t_ckp_autor ADD ds_email VARCHAR2 (40) NOT NULL; 
DESC t_ckp_autor;

    -- 5. Na tabela “T_CKP _AUTOR”, crie a instrução SQL, comando DDL para alterar o tamanho da coluna “ds_email” para 60 caracteres e elimine a constraint NOT NULL da coluna “ds_email”, utilizando uma única instrução.

ALTER TABLE t_ckp_autor MODIFY ds_email VARCHAR2 (60) NULL; 
DESC t_ckp_autor; 

    -- 6. Na tabela “T_CKP_AUTOR_LIVRO”, crie a instrução SQL, comando DDLpara alterar o tamanho da coluna “nr_isbn” para 13 dígitos.

ALTER TABLE t_ckp_autor_livro MODIFY nr_isbn NUMBER (13); 
DESC t_ckp_autor_livro;

    -- 7. Na tabela “T_CKP_LIVRO”, crie a instrução SQL, comando DDL para alteraro tamanho da coluna “nr_isbn” para 13 dígitos. Observe que esta coluna é uma chave primária, uma vez alterada, se faz necessário alterar a chave estrangeira também, como feito primeiramente no item 2.6.

ALTER TABLE t_ckp_livro MODIFY nr_isbn NUMBER (13); 
DESC t_ckp_livro;
 
    -- 8. Na tabela “T_CKP_AUTOR”, crie a instrução SQL, comando DDL para alterar adicionar a coluna “nm_pais_origem” (nome do país de origem do autor), com tipo de dado VARCHAR2, tamanho 30 caracteres e não obrigatório (opcional).
    
ALTER TABLE t_ckp_autor ADD nm_pais_origem VARCHAR2 (30) NULL; 
DESC t_ckp_autor;

    --9. Na tabela “T_CKP_LIVRO”, crie a instrução SQL, comando DDL para alterar adicionar a constraint UNIQUE para a coluna “nm_titulo”. Nomeie a constraint como: “UN_CKP_LIVRO_TITULO”.
    
ALTER TABLE t_ckp_livro ADD CONSTRAINT un_ckp_livro_titulo UNIQUE (nm_titulo); 

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'T_CKP_LIVRO';

    -- 10. Na tabela “T_CKP_AUTOR_LIVRO”, crie a instrução SQL, comando DDL para eliminar a constraint chave estrangeira “FK_CKP_AUTOR_LIVRO_AUTOR”.
    
ALTER TABLE t_ckp_autor_livro DROP CONSTRAINT fk_ckp_autor_livro_autor; 

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'T_CKP_AUTOR_LIVRO';

    -- 11. Na tabela “T_CKP_LIVRO”, crie a instrução SQL, comando DDL para eliminar a constraint chave primária “PK_CKP_LIVRO”, com a opção “CASCADE”, que elimina o relacionamento existente.

ALTER TABLE t_ckp_livro DROP CONSTRAINT PK_CKP_LIVRO CASCADE; 

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'T_CKP_LIVRO';

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'T_CKP_AUTOR_LIVRO';

    -- 12. Na tabela “T_CKP_CATEGORIA”, crie a instrução SQL, comando DDL para desabilitar a constraint UNIQUE “UN_CKP_CATEGORIA_SIGLA” associada a coluna “ds_sigla_categ”.

ALTER TABLE t_ckp_categoria DISABLE CONSTRAINT UN_CKP_CATEGORIA_SIGLA;

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, SEARCH_CONDITION, STATUS
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'T_CKP_CATEGORIA';







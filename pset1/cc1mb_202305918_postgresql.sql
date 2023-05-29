--Apagar o banco de dados
DROP database IF EXISTS uvv;

--Apagar o usuário samuelsantos
DROP USER IF EXISTS samuelsantos;
--Criar usuário

CREATE USER samuelsantos with createdb inherit password 'samuelsantos';

--Criar um banco de dados
CREATE DATABASE uvv
	owner samuelsantos
	template template0
	encoding 'UTF8'
	lc_collate 'pt_BR.UTF-8'
	lc_ctype 'pt_BR.UTF-8'
	allow_connections TRUE;

--Conectar-se ao banco de dados
\c 'dbname=uvv user=samuelsantos password=samuelsantos';

--Criar o esquema e autorizar usuário samuelsantos
CREATE SCHEMA lojas AUTHORIZATION samuelsantos;

--Conceder todos os privilégios ao usuário
GRANT ALL PRIVILEGES ON SCHEMA lojas TO samuelsantos;

--Colocar tabelas no esquema lojas, que pertence ao usuário samuelsantos
ALTER USER samuelsantos SET search_path TO lojas, '$user', public;
SET search_path TO lojas, '$user', public; 

COMMENT ON DATABASE uvv IS 'Esse é um banco de dados que representa a UVV.';

--Criar tabela produtos
CREATE TABLE produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome_produtos VARCHAR(255) NOT NULL,
                preco_unitario_produtos NUMERIC(10,2) CHECK (preco_unitario_produtos > 0),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produto_id PRIMARY KEY (produto_id)
);
COMMENT ON TABLE produtos IS 'Essa tabela contém dados dos produtos.';
COMMENT ON COLUMN produtos.produto_id IS 'Essa coluna é a primary key da tabela produtos e contém o id de cada produto.';
COMMENT ON COLUMN produtos.nome_produtos IS 'Essa coluna contém os nomes dos produtos.';
COMMENT ON COLUMN produtos.preco_unitario_produtos IS 'Essa coluna contém os preços unitários dos produtos.';
COMMENT ON COLUMN produtos.detalhes IS 'Essa coluna contém detalhes dos produtos.';
COMMENT ON COLUMN produtos.imagem IS 'Essa coluna contém a imagem de cada produto.';
COMMENT ON COLUMN produtos.imagem_mime_type IS 'Essa coluna contém o MIME-type de cada arquivo da imagem de cada produto.';
COMMENT ON COLUMN produtos.imagem_arquivo IS 'Essa coluna contém o arquivo de cada imagem de cada produto.';
COMMENT ON COLUMN produtos.imagem_charset IS 'Essa coluna contém os caracteres que podem ser inseridos em cada imagem.';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 'Essa coluna contém a data da última atualização de cada imagem.';

--Criar tabela lojas
CREATE TABLE lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome_loja VARCHAR NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT loja_id PRIMARY KEY (loja_id)
);
COMMENT ON TABLE lojas IS 'Essa tabela contém dados sobre as lojas.';
COMMENT ON COLUMN lojas.loja_id IS 'Essa coluna é a primary key da tabela lojas e contém o id de cada loja.';
COMMENT ON COLUMN lojas.nome_loja IS 'Essa coluna contém os nomes das lojas.';
COMMENT ON COLUMN lojas.endereco_web IS 'Essa coluna contém o endereço web das lojas.';
COMMENT ON COLUMN lojas.endereco_fisico IS 'Essa coluna contém os endereços físicos das lojas.';
COMMENT ON COLUMN lojas.latitude IS 'Essa tabela contém as latitudes das lojas.';
COMMENT ON COLUMN lojas.longitude IS 'Essa coluna contém as longitudes das lojas.';
COMMENT ON COLUMN lojas.logo IS 'Essa coluna contém as logos das lojas.';
COMMENT ON COLUMN lojas.logo_mime_type IS 'Essa coluna contém o MIME-type dos arquivos das logos das lojas.';
COMMENT ON COLUMN lojas.logo_arquivo IS 'Essa coluna contém os arquivos das logos das lojas.';
COMMENT ON COLUMN lojas.logo_charset IS 'Essa coluna contém o conjunto de caracteres que poderá ser utilizado em cada logo de cada uma das lojas.';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 'Essa coluna contém a data da última atualização da logo de cada loja.';

--Criar tabela estoques
CREATE TABLE estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC NOT NULL,
                CONSTRAINT estoque_id PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE estoques IS 'Essa tabela contém dados do estoques das lojas.';
COMMENT ON COLUMN estoques.estoque_id IS 'Essa coluna contém o id de cada estoque.';
COMMENT ON COLUMN estoques.loja_id IS 'Essa coluna é a foreign key da tabela estoques e contém o id de cada loja.';
COMMENT ON COLUMN estoques.produto_id IS 'Essa coluna é a foreign key da tabela estoques e contém o id de cada produto.';
COMMENT ON COLUMN estoques.quantidade IS 'Essa coluna contém a quantidade existente de cada produto.';

--Criar tabela clientes
CREATE TABLE clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT cliente_id PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE clientes IS 'Essa é a tabela contém os dados sobre os clientes.';
COMMENT ON COLUMN clientes.cliente_id IS 'Essa coluna é a primary key da tabela clientes e contém o id de cada um deles.';
COMMENT ON COLUMN clientes.email IS 'Essa coluna contém os endereços de email de cada cliente.';
COMMENT ON COLUMN clientes.nome IS 'Essa coluna contém os nomes dos clientes.';
COMMENT ON COLUMN clientes.telefone1 IS 'Essa coluna contém o primeiro número de telefone dos clientes.';
COMMENT ON COLUMN clientes.telefone2 IS 'Essa coluna contém o segundo número de telefone dos clientes.';
COMMENT ON COLUMN clientes.telefone3 IS 'Essa coluna contém o terceiro número de telefone dos clientes.';

--Criar tabela envios
CREATE TABLE envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status_envios VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id)
);
COMMENT ON TABLE envios IS 'Essa tabela contém dados dos envios das lojas para os clientes.';
COMMENT ON COLUMN envios.envio_id IS 'Essa coluna é a primary key da tabela envios e contém o id de cada envio.';
COMMENT ON COLUMN envios.loja_id IS 'Essa coluna é uma foreign key da tabela envios e contém o id de cada loja.';
COMMENT ON COLUMN envios.cliente_id IS 'Essa coluna é uma foreign key da tabela envios e contém o id de cada um deles.';
COMMENT ON COLUMN envios.endereco_entrega IS 'Essa coluna contém os endereços de entrega dos envios.';
COMMENT ON COLUMN envios.status_envios IS 'Essa coluna contém o status de cada envio.';

--Criar tabela pedidos
CREATE TABLE pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE pedidos IS 'Essa tabela contém os dados dos pedidos feitos pelos clientes.';
COMMENT ON COLUMN pedidos.pedido_id IS 'Essa coluna é a primary key da tabela pedidos e contém o id de cada pedido.';
COMMENT ON COLUMN pedidos.data_hora IS 'Essa coluna contém a data e a hora em que foram registrados os pedidos dos clientes.';
COMMENT ON COLUMN pedidos.cliente_id IS 'Essa coluna é uma foreign key da tabela pedidos e contém o id de cada cliente.';
COMMENT ON COLUMN pedidos.status IS 'Essa coluna contém os status dos alunos.';
COMMENT ON COLUMN pedidos.loja_id IS 'Essa coluna é a foreign key da tabela pedidos e contém o id de cada loja.';

--Criar tabela pedidos_itens
CREATE TABLE pedidos_itens (
                pedido_id_pedidos_itens NUMERIC(38) NOT NULL,
                produto_id_pedidos_itens NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade_pedidos_itens NUMERIC NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pedido_id_pk PRIMARY KEY (pedido_id_pedidos_itens, produto_id_pedidos_itens)
);
COMMENT ON TABLE pedidos_itens IS 'Essa tabela contém itens dos pedidos.';
COMMENT ON COLUMN pedidos_itens.pedido_id_pedidos_itens IS 'Essa coluna é uma primary foreign key da tabela pedidos_itens e contém o id de cada pedido.';
COMMENT ON COLUMN pedidos_itens.produto_id_pedidos_itens IS 'Essa coluna é a primary foreign key da tabela pedidos_itens e contém o id de cada produto.';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 'Essa coluna contém o número da linha de cada produto.';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 'Essa coluna contém o preço unitario de cada produto.';
COMMENT ON COLUMN pedidos_itens.quantidade_pedidos_itens IS 'Essa coluna contém a quantidade de produtos de cada pedido.';
COMMENT ON COLUMN pedidos_itens.envio_id IS 'Essa coluna é a foreign key da tabela envios e contém o id de cada envio.';

--Adicionar FK produto_id à tabela estoques
ALTER TABLE estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--Adicionar FK produto_id à tabela pedidos_itens
ALTER TABLE pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id_pedidos_itens)
REFERENCES produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionar FK loja_id à tabela pedidos
ALTER TABLE pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES uvv.lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionar FK loja_id à tabela estoques
ALTER TABLE estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionar FK loja_id à tabela envios
ALTER TABLE envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionar FK cliente_id à tabela pedidos
ALTER TABLE pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionar FK cliente_id à tabela envios
ALTER TABLE envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionar FK envio_id à tabela pedidos_itens
ALTER TABLE pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionar FK pedido_id_pedidos_itens à tabela pedidos_itens
ALTER TABLE pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id_pedidos_itens)
REFERENCES pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--Adicionar check constraint para que preco_unitario_produtos seja igual ou maior que zero
ALTER TABLE produtos 
ADD CONSTRAINT preco_unitario_zero_ou_mais
CHECK (preco_unitario_produtos>=0);

--Adicionar check constraint para que produto_id seja igual a zero ou mais
ALTER TABLE produtos
ADD CONSTRAINT produto_id_zero_ou_mais
CHECK (produto_id >=0);

--Adicionar check constraint para que preco_unitario seja igual a zero ou mais
ALTER TABLE pedidos_itens
ADD CONSTRAINT preco_unitario_zero_oumais
CHECK (preco_unitario>=0);

--Adicionar check constraint para que quantidade_pedidos_itens seja igual a zero ou mais
ALTER TABLE pedidos_itens
ADD CONSTRAINT quantidade_zero_ou_mais
CHECK (quantidade_pedidos_itens>=0);

--Adicionar check constraint para que loja_id seja igual a zero ou mais
ALTER TABLE lojas
ADD CONSTRAINT loja_id_zero_ou_mais
CHECK (loja_id>=0);

/*Adicionar check constraint para que seja obrigatório o preenchimento
de pelo menos uma das colunas de endereço(web ou físico).*/
ALTER TABLE lojas
ADD CONSTRAINT enderecos
CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);

--Adicionar check constraint para que quantidade seja igual a zero ou mais
ALTER TABLE estoques
ADD CONSTRAINT quantidade_zero_oumais
CHECK (quantidade>=0);

--Adicionar check constraint para que pedido_id seja igual a zero ou mais
ALTER TABLE pedidos
ADD CONSTRAINT pedido_id_zero_ou_mais 
CHECK (pedido_id>=0);

--Adicionar check constraint para que status só aceite os valores CANCELADO,COMPLETO,ABERTO,PAGO,REEMBOLSADO OU ENVIADO
ALTER TABLE pedidos
ADD CONSTRAINT status
CHECK (status IN ('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSADO','ENVIADO'));

--Adicionar check constraint para que cliente_id seja igual a zero ou mais
ALTER TABLE clientes
ADD CONSTRAINT cliente_id_zero_ou_mais
CHECK (cliente_id>=0);

--Adicionar check constraint para que envio_id seja igual a zero ou mais
ALTER TABLE envios
ADD CONSTRAINT envio_id_zero_ou_mais
CHECK (envio_id>=0);

--Adicionar check constraint para que status_envios só aceite os valores CRIADO,ENVIADO,TRANSITO OU ENTREGUE
ALTER TABLE envios
ADD CONSTRAINT status_envios
CHECK (status_envios IN ('CRIADO','ENVIADO','TRANSITO','ENTREGUE'));






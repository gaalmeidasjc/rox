# Desafio ROX

Este repositório tem como objetivo armazenar a resolução do desafio proposto pela ROX.

**Index**

1. [NiFi](#nifi)
2. [Base de dados](#base-de-dados)
3. [Ingestão](#ingestão)
4. [Análise de dados](#análise-de-dados)

# NiFi
A ingestão foi criada atravéz do NiFi. Para utiliza-la basta importar o template [Rox.xml](https://github.com/gaalmeidasjc/rox/blob/main/Rox.xml "Template Rox.xml") no NiFi e realizar os seguintes passos para configuração.

1. Com o fluxo importado, o primeiro passo é configurar o diretório em que o processor GetFile ficará analisando se entrou um novo arquivo. Para isso existe uma variável chamada file_path. Basta apontar para o diretório que será utilizado para colocar os arquivos (csv) para importação:

![filepath](https://github.com/gaalmeidasjc/rox/blob/main/imagens/file_path.png?raw=true)

Obs.: Existe um diretório no repositório com o nome files. Poderá ser utilizado ele.

2. O fluxo utiliza um controller service para comunicação com o banco de dados que no caso desta solução, foi escolhido o SQL Server (Microsoft). Precisamos configurar a conexão com o banco. Para desenvolvimento e testes foi realizado a configuração com um banco em núvem (GCP), porém, funcionará caso utilize On-Premise. Abrindo a parte de configurações temos a aba `CONTROLLER SERVICE`. Precisaremos alterar o controller service `DBCPConnectionPool`.
- Em **Database Connection URL** deverá ser preenchido o ip para conexão a sua instancia do SQL Server:
![database_connection](https://github.com/gaalmeidasjc/rox/blob/main/imagens/database_connection.png?raw=true)

- Em **Database Driver Location** deverá ser apontado o diretório do driver de conexão com o banco. O repositório já possuí o driver para conexão, bastando apenas apontar para a pasta ptb dentro do diretório sqljdbc_9.4:
![database_driver](https://github.com/gaalmeidasjc/rox/blob/main/imagens/database_driver.png?raw=true)

3. Após configuração, basta habilitar todos os controller services e executar o fluxo.
![flow](https://github.com/gaalmeidasjc/rox/blob/main/imagens/flow.png?raw=true)

# Base de dados
Antes de ingerirmos os dados, é necessário a criação do banco de dados com as devidas tabelas e relacionamentos. Para isso, temos no repositório o arquivo de [criação de tabelas](https://github.com/gaalmeidasjc/rox/blob/main/CREATE.sql).

Basta executar o script conectado em sua instância do SQL Server para a criação de toda a estrutura.

# Ingestão
Para realizarmos a ingestão, devemos tomar alguns cuidados. Por se tratar de um banco de dados relacional, certas tabelas dependem de registros incluídos em outras tabelas para relacionamento correto, portanto, a seguinte ordem deverá ser executada:

- Person / Product;
- Customer;
- SalesOrderHeader;
- SpecialOfferProduct;
- SalesOrderDetail.

Uma ingestão só poderá ser iniciada caso a ultima tenha sido concluída, caso contrário acabará ocasionando erro de chave não encontrada.

O processo de ingestão é bem simples. Basta copiar o arquivo a ser ingerido para dentro do diretório configurado no processor GetFile no NiFi.
O processo irá iniciar automaticamente, excluindo o arquivo do diretório para não haver ingestão duplicada.

**Ponto de atenção**

O direcionamento do fluxo para correta ingestão do arquivo na tabela é definido pelo nome do arquivo, portanto, o arquivo deverá ter o nome da tabela.

# Análise de dados
Por fim, existe um ultimo [script](https://github.com/gaalmeidasjc/rox/blob/main/An%C3%A1lise%20de%20dados.sql) referente as análises de dados solicitadas no desafio. As cinco análises propostas estão no mesmo script, sinalizado pelos números.
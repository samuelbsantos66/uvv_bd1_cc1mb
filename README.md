# PSET (Design e Desenvolvimento de Banco de Dados)  

## Aluno: Samuel Barbosa Santos

## Turma: cc1mb

## Professor: Abrantes Araújo Silva Filho

## Monitora: Suellen Miranda Amorim

  Esse repositório contém as soluções para um Pset que foi apresentado para a minha turma de graduação em Ciência da Computação.
O Pset, ou Problems Sets, são desafios de elevada dificuldade, que têm como objetivo estimular a capacidade de resolução de problemas dos estudantes e podem ser aplicados a diversas matérias de uma determinada grade curricular.
  
  Nessa perspectiva, eu e meus colegas fomos desafiados, cada um, a implementar, com o SGBD postgreSQL, um banco de dados com um esquema e suas respectivas tabelas, além de responder questões discursivas sobre o processo. Nosso ponto de partida foi o seguinte diagrama relacional:
  
  
  
  
  
  ![Diagrama Relacional: Lojas UVV](lojas-uvv.png)
  
  
  
  
  
  Esse diagrama tem como objetivo representar o cenário das lojas presentes na UVV(Universidade de Vila Velha), bem como os elementos desse contexto, que serão convertidos em colunas de tabelas que aceitarão diversos tipos de dados.

### IMPLEMENTAÇÃO

1. Gerei o projeto lógico do diagrama relacional utilizando o software [Power Architect](https://bestofbi.com/architect-download/).  
2. Configurei um script em sql para o postgreSQL baseado no projeto lógico,gerando-o com o Power Architect e depois o editando com o  [DBeaver](https://dbeaver.io/download/).  
3. Por fim, me conectei ao SGBD postgresSQL por meio do terminal do sistema operacional Linux para rodar o script e implementar o banco de dados UVV(que contém o esquema lojas).

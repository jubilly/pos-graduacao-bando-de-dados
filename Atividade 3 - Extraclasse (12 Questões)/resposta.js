// Questão 1 - Quais os funcionários não possuem nenhuma skill?

use('funcionario');

db.funcionario.find({
    $or: [
      {
        skill: {
          $exists: false,
        },
      },
      { skill: "" },
      { skill: { $exists: null } },
    ],
}).pretty();


// Questão 2 - Quais os funcionários possuem algum hobby? Mostrar o nome e o hobby.

db.funcionario.find({
    $or: [
      {
        hobbies: {
          $exists: true,
          $ne: []
        },
      }
    ],
}).pretty();

// Questão 3 - Seleciona os funcionários que não é vendedor, não mora em Vitória da Conquista e tem menos de 3 filhos. 
// Não mostrar os hobbies, as notas e as avaliações. 

// Questão 4 - Seleciona os funcionários com função de programador e de analista que ganham acima de R$ 2.000,00. 
// Classificar em ordem crescente pela função e nome do funcionário. Utilizar o operador sort. 

// Questão 5 - Quais os funcionários têm como hobby futebol e tênis de mesa? Não mostrar o salário e a data de admissão. 
// Utilizar o operador $all. 

// Questão 6 - Quais os funcionários têm 4 hobbies, sendo que pelo menos 1 hobby seja natação? Mostrar o nome e os 
// hobbies. Utilizar o operador $size. 

// Questão 7 - Quantos funcionários moram em Vitória da Conquista e possuem algum hobby? Utilizar a notação ponto. 

// Questão 8 - Quais  os  funcionários  com  notas  de  produção  e convívio acima  de  7,5?  Mostrar  o  nome,  a  função e  as 
// notas. Utilizar a notação ponto. 

// Questão 9 - Responder a consulta anterior com o operador $elemMatch. 

// Questão 10 - Qual  a  primeira  opção  de  hobby  dos  funcionários?  Considerar  que  o  primeiro  elemento  do  array  é  a 
// primeira opção. Mostrar somente o nome e o hobby. Utilizar o operador $slice. 

// Questão 11 - Quais  os  funcionários  têm  3  ou  4  feedbacks?  Mostrar  o  nome  e  os  feedbacks  ordenado  em  ordem 
// decrescente pelo nome. 

// Questão 12 - Recuperar  os  funcionários  que  possuem  os  três  maiores  salários,  excluindo  o  funcionário  com  o  maior 
// salário. Não mostrar os hobbies, as notas, as avaliações, os feedbacks e o endereço.
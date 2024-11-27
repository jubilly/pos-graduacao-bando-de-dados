/*

    Atividade 4 - Consulta Simples com Find (12 Questões)
    Aluna: Amanda Prates Caetano
    Disciplina: Banco de dados

*/

// Respostas abaixo

// Questão 1 - Quais os funcionários não possuem nenhuma skill?

use('empresa');

db.funcionario.find({
    $or: [
      {
        "skill": {
          $exists: false,
        },
      },
      { "skill": "" },
      { "skill": { $exists: null } },
    ],
});


// Questão 2 - Quais os funcionários possuem algum hobby? Mostrar o nome e o hobby.

db.funcionario.find({
    $or: [
      {
        "hobbies": {
          $exists: true,
          $ne: []
        },
      }
    ],
});

// Questão 3 - Seleciona os funcionários que não é vendedor, não mora em Vitória da Conquista e tem menos de 3 filhos. 
// Não mostrar os hobbies, as notas e as avaliações. 

db.funcionario.find(
    {
        "funcao": { $ne: "VENDEDOR" },
        "endereco.cidade": { $ne: "VITÓRIA DA CONQUISTA" },
        "filhos": { $gte: 3 },
    },
    {
        "hobbies": 0,
        "notas": 0,
        "avaliacoes": 0
    }
);

// Questão 4 - Seleciona os funcionários com função de programador e de analista que ganham acima de R$ 2.000,00. 
// Classificar em ordem crescente pela função e nome do funcionário. Utilizar o operador sort. 

db.funcionario.find(
    {
        "funcao": {
            $in: [
                "PROGRAMADOR",
                "ANALISTA"
            ]
        },
        "salario": { $gte: 2000 },
    }
).sort({ "nome": 1 });

// Questão 5 - Quais os funcionários têm como hobby futebol e tênis de mesa? Não mostrar o salário e a data de admissão. 
// Utilizar o operador $all. 

db.funcionario.find(
    {
        "hobbies": { 
            $all: ['TÊNIS DE MESA', 'FUTEBOL']
        }
    },
    {
        "salario": 0,
        "admissao": 0
    }
);

// Questão 6 - Quais os funcionários têm 4 hobbies, sendo que pelo menos 1 hobby seja natação? Mostrar o nome e os 
// hobbies. Utilizar o operador $size.

db.funcionario.find(
    {
        $and: [
            {
                "hobbies": { 
                    $size: 4
                }
            },
            {
                "hobbies": "NATAÇÃO"
            }
        ]
    }
)

// Questão 7 - Quantos funcionários moram em Vitória da Conquista e possuem algum hobby? Utilizar a notação ponto. 

db.funcionario.find({
    $and: [
        {
            "hobbies": { 
                $exists: true
            }
        },
        {
            "endereco.cidade": "VITÓRIA DA CONQUISTA"
        }
    ]
});


// Questão 8 - Quais  os  funcionários  com  notas  de  produção  e convívio acima  de  7,5?  Mostrar  o  nome,  a  função e  as 
// notas. Utilizar a notação ponto.

db.funcionario.find(
    {
        $and: [
            {
                "notas.0.criterio" : "PRODUÇÃO",
                "notas.0.nota": { $gt: 7.5 }
            },
            {
                "notas.1.criterio" : "CONVÍVIO",
                "notas.1.nota": { $gt: 7.5 }
            }
        ]
    }, 
    {
        "nome": 1, 
        "funcao": 1, 
        "notas": 1, 
        "_id": 0
    }
);

// Questão 9 - Responder a consulta anterior com o operador $elemMatch. 


db.funcionario.find(
    {
        $and: [
            {
                "notas": {
                    $elemMatch: {
                        "criterio": "PRODUÇÃO",
                        "nota": { $gte: 7.5 }
                    }
                }
            },
            {
                "notas": {
                    $elemMatch: {
                        "criterio": "CONVÍVIO",
                        "nota": { $gte: 7.5 }
                    }
                }
            }
        ]
    },
    {
        "nome": 1, 
        "funcao": 1, 
        "notas": 1, 
        "_id": 0
    }
);

// Questão 10 - Qual  a  primeira  opção  de  hobby  dos  funcionários?  Considerar  que  o  primeiro  elemento  do  array  é  a 
// primeira opção. Mostrar somente o nome e o hobby. Utilizar o operador $slice. 

db.funcionario.find(
    {},
    {
        "_id": 0,
        "nome": 1,
        "hobbies": { $slice: 1 }
    }
);

// Questão 11 - Quais  os  funcionários  têm  3  ou  4  feedbacks?  Mostrar  o  nome  e  os  feedbacks  ordenado  em  ordem 
// decrescente pelo nome. 

db.funcionario.find(
    {
        $or: [
            {
                "feedbacks": { $size: 3 },
            },
            {
                "feedbacks": { $size: 4 },
            },
        ]
    },
    {
        "nome": 1,
        "feedbacks": 1,
        "_id": 0
    }
).sort({ "nome": -1 });

// Questão 12 - Recuperar  os  funcionários  que  possuem  os  três  maiores  salários,  excluindo  o  funcionário  com  o  maior 
// salário. Não mostrar os hobbies, as notas, as avaliações, os feedbacks e o endereço.


db.funcionario.find({}, {
    "hobbies": 0,
    "notas": 0,
    "avaliacoes": 0,
    "feedbacks": 0,
    "endereco": 0
}).sort({ "salario": -1 }).skip(1).limit(3);
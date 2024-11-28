/*

    Atividade 4 - Consulta Simples com Find (12 Questões)
    Aluna: Amanda Prates Caetano
    Disciplina: Banco de dados

    1. Utilizar a base de dados Empresa disponível no Google Classroom para responder as questões; 
    2. Utilize o método aggregate() para realizar as consultas a seguir. 
    Elaborar as seguintes consultas no MongoDB: 
    
    Questão com $match e $project SEM agrupamento

*/

// Respostas abaixo

// Questão 1 - Quais os funcionários do departamento 2 recebem salário entre R$ 2.000,00 e R$ 3.000,00? Mostrar o nome, 
// o departamento e o salário do funcionário.

use('empresa');

db.funcionario.aggregate([
    {
      $match: {
        depto: 2,
        salario: { $gte: 2000, $lte: 3000 }
      }
    },
    {
      $project: {
        _id: 0,
        nome: 1,
        depto: 1,
        salario: 1
      }
    }
]);


// Questão 2 - Quais funcionários foram admitidos no primeiro semestre depois de 2008? Mostrar o nome e o ano da data 
// de admissão do funcionário. Classificar os funcionários por data de admissão em ordem decrescente. Utilize 
// os  operadores  de  expressão  $year  e  $month  para  saber,  respectivamente,  o  ano  e  o  mês  da  data  de 
// admissão

db.funcionario.aggregate([
    {
      $project: {
        _id: 0,
        nome: 1,
        admissao: 1,
        admissionYear: { $year: "$admissao" },
        admissionMonth: { $month: "$admissao" }
      }
    },
    {
      $match: {
        admissionYear: { $gt: 2008 },
        admissionMonth: { $lte: 6 },
      }
    },
    {
      $project: {
        nome: 1,
        admissao: {
          $toDate: "$admissao"
        }
      }
    },
    {
      $sort: {
        "admissao": -1 
      }
    }
  
]);

// Questões de $push, $addToSet e $size com o operador $group 
// 3. Quais os nomes dos funcionários por função? Mostrar somente os funcionários cuja função seja programador 
// e analista. Utilizar o operador $push.

db.funcionario.aggregate([
    {
        $match: {
            funcao: { $in: ['PROGRAMADOR', 'ANALISTA']}
        }
    },
    {
        $group: {
            _id: "$funcao",
            funcionarios: { 
                $push: "$nome"
            }
        }
    }
]);

// Questão 4 -  Quais os nomes dos funcionários alocados por cidade?  Utilizar a notação ponto para acessar a cidade e  o 
// operador $push

db.funcionario.aggregate([
    {
        $match: {
            "endereco.cidade": { $exists: true }
        }
    },
    {
        $group: {
            _id: "$endereco.cidade",
            funcionarios: { 
                $push: "$nome"
            }
        }
    }
]);

// Questão 5 - Qual a quantidade de funções por cada departamento? Contar as funções repetidas no departamento. Utilizar 
// os operadores $push e $size (ou $sum).


db.funcionario.aggregate([
    {
        $group: {
            _id: "$depto",
            funcoes: {
                $push: {
                    funcao: "$funcao"
                }
            }
        }
    },
    {
        $project: {
            _id: 1,
            quantidadeFuncoes: { $size: "$funcoes" }
        }
    }
]);

// Questão 6 - Qual a quantidade de funções por cada departamento? Não contar as funções repetidas no departamento. 
// Utilizar os operadores $addToSet e $size.


db.funcionario.aggregate([
    {
        $group: {
            _id: "$depto",
            funcoes: {
                $addToSet: "$funcao" 
            }
        }
    },
    {
        $project: {
            _id: 1,
            quantidadeFuncoes: { $size: "$funcoes" }
        }
    }
]);

// Questão 7 - Qual  o  total  de  feedbacks  por  funcionário?  Mostrar  o  nome  do  funcionário  e  o  total  de  feedbacks  dos  5 
//funcionários com maiores feedbacks. Utilizar os operadores $exists, $size, $sort e $limit

db.funcionario.aggregate([
    {
        $match: {
            "feedbacks": { $exists: true }
        }
    },
    {
        $project: {
          nome: 1,
          total_feedbacks: { 
            $size: "$feedbacks"
          }
        }
    },
    {
        $sort: {
          total_feedbacks: -1 
        }
    },

]);


// Questões $min, $max, $avg, $sum com o operador $group 
// Questão 8 - Qual a data de admissão do funcionário mais antigo e o mais recente, cuja função é supervisor? 

db.funcionario.aggregate([
    {
        $match: {
            "funcao": { $exists: true },
            "funcao": "SUPERVISOR"
        }
    },
    {
        $group: {
            _id: null,
            antigo: { $min: "$admissao" },
            recente: { $max: "$admissao" }
        }
    },
    {
        $project: {
            _id: 0,
            antigo: 1,
            recente: 1
        }
    }
]);

// Questão 9 - Qual a média de filhos dos funcionários da empresa por função? Utilizar o operador $exists.

db.funcionario.aggregate([
    {
        $match: {
            "filhos": { $exists: true }
        }
    },
    {
        $group: {
            _id: "$funcao",
            media: { 
                $avg: "$filhos" 
            }
        }
    },
    {
        $project: {
            _id: 0,
            funcao: "$_id",
            media: 1
        }
    }

]);

// Questão 10 - Qual o valor total de salário pago aos funcionários que recebem salário entre R$ 2.000,00 e R$ 3.000,00 de 
// acordo com a função? Utilizar o operador $and. 

db.funcionario.aggregate([
    {
      $match: {
        $and: [
          { salario: { $gte: 2000 } },
          { salario: { $lte: 3000 } }
        ]
      }
    },
    {
      $project: {
        nome: 1,
        salario: 1,
        funcao: 1
      }
    },
    {
      $group: {
        _id: "$funcao",
        total_salario: { $sum: "$salario" }
      }
    },
    {
      $project: {
        _id: 0,
        funcao: "$_id",
        total_salario: 1
      }
    }
]);


// Questão 11 - Qual o valor total de salário pago aos funcionários de acordo com a função? Mostrar somente as funções as 
// quais possuem o total de salário entre R$ 2.000,00 e R$ 3.000,00. Utilizar o operador $and 

db.funcionario.aggregate([
    {
        $group: {
            _id: "$funcao",
            total_salario: { $sum: "$salario" }
        }
    },
    {
        $match: {
            $and: [
                { total_salario: { $gte: 2000 } },
                { total_salario: { $lte: 3000 } }
            ]
        }
    },
    {
        $project: {
            _id: 0,
            funcao: "$_id",
            total_salario: 1
        }
    }
]);

// Questão $unwind com o operador $group 
// Questão 12 - Qual  a  quantidade  de  ocorrência  de  cada  hobby?  Ordenar  em  ordem  decrescente  pela  quantidade  com  o 
// operador $sort. Utilizar o operador $unwind para desmembrar o array. Mostrar somente os 3 primeiros 
// documentos com o operador $limit.

db.funcionario.aggregate([
    {
      $unwind: "$hobbies"
    },
    {
      $group: {
        _id: "$hobbies", 
        qtd: { $sum: 1 }
      }
    },
    {
      $sort: {
        qtd: -1
      }
    },
    {
      $limit: 3
    }
]);
  
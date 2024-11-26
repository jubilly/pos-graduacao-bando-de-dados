// ======================
// Banco de Dados Agendamento Auditório
// ======================

// Cria o banco de dados empresa
use agendamentoauditorio

// Insere um documento na coleção administrador

db.administrador.insertMany(
    {
        "_id" : NumberInt(1),
        "nome" : "Pablo Freire Matos",
        "login" : "pablo",
        "senha" : "matos"
    },
    {
        "_id" : 2,
        "nome" : "Liojes de Oliveira Carneiro",
        "login" : "Liojes",
        "senha" : "Carneiro"
    }
);

// Insere um documento na coleção Equipamento

db.equipamento.insertMany([
    {
        "_id" : 1,
        "nome" : "Data Show",
        "status" : "disponível",
        "dataHoraAtualizacaoStatus" : "2024-11-23T15:36:07Z"
    },
    {
        "_id" : 2,
        "nome" : "Lousa Digital",
        "status" : "disponível",
        "dataHoraAtualizacaoStatus" : "2024-11-23T15:36:07Z"
    },
    {
        "_id" : 3,
        "nome" : "Microfone",
        "status" : "disponível",
        "dataHoraAtualizacaoStatus" : "2024-11-23T15:36:07Z"
    },
    {
        "_id" : 4,
        "nome" : "Caixa de Som",
        "status" : "não disponível",
        "dataHoraAtualizacaoStatus" : "2024-11-23T15:36:07Z"
    },
    {
        "_id" : 5,
        "nome" : "Quadro Branco",
        "status" : "não disponível",
        "dataHoraAtualizacaoStatus" : "2024-11-23T15:36:07Z"
    },
    {
        "_id" : 6,
        "nome" : "Notebook",
        "status" : "disponível",
        "dataHoraAtualizacaoStatus" : "2024-11-23T15:36:07Z"
    }
]);

db.reservas.insertMany([
    {
        "_id" : 1,
        "motivo" : "Reserva Pessoal",
        "horaFinal" : "12:00:00",
        "horaInicial" : "10:00:00",
        "status" : "reservado",
        "data" : "2019-10-05T00:00:00Z",
        "dataHoraSolicitacao" : "2024-11-23T00:00:00Z",
        "solicitante": {
            "siape" : 1,
            "nome" : "Marcélia Porto Rocha",
            "email" : "murilo@gmail.com",
            "telefones": [
                {
                    "siape" : 1,
                    "telefone" : "77988112622"
                },
                {
                    "siape" : 1,
                    "telefone" : "77999984511"
                }
            ]
        },
        "equipamentos": [
            {
                "id" : NumberInt(1),
                "nome" : "Data Show"
            },
            {
                "id" : NumberInt(2),
                "nome" : "Lousa Digital"
            },
            {
                "id" : NumberInt(3),
                "nome" : "Microfone"
            }
        ]
    },
    {
        "_id" : 2,
        "motivo" : "Reserva Pessoal",
        "horaFinal" : "18:00:00",
        "horaInicial" : "14:00:00",
        "status" : "reservado",
        "data" : "2019-10-05T00:00:00Z",
        "dataHoraSolicitacao" : "2024-11-23T00:00:00Z",
        "solicitante": {
            "siape" : 1,
            "nome" : "Marcélia Porto Rocha",
            "email" : "murilo@gmail.com",
            "telefones": [
                {
                    "siape" : 1,
                    "telefone" : "77988112622"
                },
                {
                    "siape" : 1,
                    "telefone" : "77999984511"
                }
            ]
        },
        "equipamentos":[
            {
                "id" : NumberInt(1),
                "nome" : "Data Show"
            },
            {
                "id" : NumberInt(3),
                "nome" : "Microfone"
            }
        ]
    },
    {
        "_id" : 3,
        "motivo" : "Reserva Pessoal",
        "horaFinal" : "12:00:00",
        "horaInicial" : "08:00:00",
        "status" : "reservado",
        "data" : "2019-10-06T00:00:00Z",
        "dataHoraSolicitacao" : "2024-11-23T00:00:00Z",
        "solicitante": {
            "siape" : 1,
            "nome" : "Marcélia Porto Rocha",
            "email" : "murilo@gmail.com",
            "telefones": [
                {
                    "siape" : 1,
                    "telefone" : "77988112622"
                },
                {
                    "siape" : 1,
                    "telefone" : "77999984511"
                }
            ]
        },
        "equipamentos": [
            {
                "id" : NumberInt(2),
                "nome" : "Lousa Digital"
            },
            {
                "id" : NumberInt(3),
                "nome" : "Microfone"
            }
        ]
    },
    {
        "_id" : 17,
        "motivo" : "Reserva Pessoal",
        "horaFinal" : "2024-12-23 15:30:00",
        "horaInicial" : "2024-12-23 13:30:00",
        "status" : "reservado",
        "dataHoraSolicitacao" : "2024-10-08 17:30:48",
        "solicitante" : { 
            "siape" : NumberInt(1),
            "nome" : "Marcélia Porto Rocha",
            "email" : "murilo@gmail.com",
            "telefones": [ 
                {
                    "siape" : NumberInt(1),
                    "telefone" : "77988112622"
                },
                {
                    "siape" : NumberInt(1),
                    "telefone" : "77999984511"
                }
            ]
        },
        "equipamentos": [
            {
                "id" : NumberInt(6),
                "nome" : "Notebook"
            }
        ]
    },
    {
        "_id" : 4,
        "motivo" : "Reserva Pessoal",
        "horaFinal" : "18:00:00",
        "horaInicial" : "14:00:00",
        "status" : "reservado",
        "data" : "2019-10-06T00:00:00Z",
        "dataHoraSolicitacao" : "2024-11-23T15:36:07Z",
        "solicitante": {
            "siape" : 2,
            "nome" : "Gutemberg Júnior",
            "email" : "gutemberg@hotmail.com",
            "telefones": [
                {
                    "siape" : 2,
                    "telefone" : "77988554355"
                },
                {
                    "siape" : 2,
                    "telefone" : "77991657844"
                },
                {
                    "siape" : 2,
                    "telefone" : "77998552233"
                }
            ]
        },
        "equipamentos": [
            {
                "id" : NumberInt(1),
                "nome" : "Data Show"
            },
            {
                "id" : NumberInt(2),
                "nome" : "Lousa Digital"
            },
            {
                "id" : NumberInt(3),
                "nome" : "Microfone"
            }
        ]
    }
]);


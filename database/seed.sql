USE petvida;

INSERT INTO especies (nome) VALUES
('Cachorro'),
('Gato'),
('Pássaro'),
('Peixe'),
('Réptil');

INSERT INTO veterinarios (nome, crmv, especialidade, telefone) VALUES
('Carlos Silva', 'CRMV001', 'Clínico Geral', '(71)99999-1111'),
('Ana Souza', 'CRMV002', 'Dermatologia', '(71)99999-2222'),
('Fernanda Lima', 'CRMV003', 'Cirurgia', '(71)99999-3333');

INSERT INTO tutores (nome, cpf, email, telefone) VALUES
('João Pereira', '111.111.111-11', 'joao@email.com', '(71)98888-1111'),
('Maria Santos', '222.222.222-22', 'maria@email.com', '(71)98888-2222'),
('Pedro Oliveira', '333.333.333-33', 'pedro@email.com', '(71)98888-3333'),
('Juliana Costa', '444.444.444-44', 'juliana@email.com', '(71)98888-4444'),
('Lucas Almeida', '555.555.555-55', 'lucas@email.com', '(71)98888-5555'),
('Camila Rocha', '666.666.666-66', 'camila@email.com', '(71)98888-6666'),
('Rafael Dias', '777.777.777-77', 'rafael@email.com', '(71)98888-7777'),
('Patricia Gomes', '888.888.888-88', 'patricia@email.com', '(71)98888-8888');

INSERT INTO animais (nome, especie_id, raca, data_nascimento, tutor_id) VALUES
('Rex', 1, 'Labrador', '2020-05-10', 1),
('Mia', 2, 'Siamês', '2021-03-15', 2),
('Thor', 1, 'Pitbull', '2019-08-20', 3),
('Luna', 2, 'Persa', '2022-01-05', 4),
('Nina', 1, 'Poodle', '2020-11-12', 5),
('Bob', 1, 'Bulldog', '2018-07-07', 6),
('Mel', 2, 'Maine Coon', '2021-09-18', 7),
('Kiwi', 3, 'Calopsita', '2023-02-01', 8),
('Goldie', 4, 'Goldfish', '2022-12-10', 1),
('Spike', 5, 'Iguana', '2019-04-25', 2),
('Max', 1, 'Beagle', '2020-06-06', 3),
('Belinha', 2, 'Angorá', '2021-08-08', 4),
('Toby', 1, 'Shih Tzu', '2022-10-10', 5),
('Lili', 3, 'Papagaio', '2018-01-01', 6),
('Bruce', 5, 'Jiboia', '2017-09-09', 7);

INSERT INTO consultas
(animal_id, veterinario_id, data_hora, diagnostico, valor, status)
VALUES
(1,1,'2026-05-01 09:00:00','Check-up geral',150.00,'concluida'),
(2,2,'2026-05-01 10:00:00','Alergia na pele',200.00,'concluida'),
(3,3,'2026-05-01 11:00:00','Cirurgia preventiva',500.00,'concluida'),
(4,1,'2026-05-02 09:30:00','Vacinação',120.00,'concluida'),
(5,2,'2026-05-02 10:30:00','Queda de pelos',180.00,'concluida'),
(6,3,'2026-05-02 11:30:00','Consulta cirúrgica',300.00,'agendada'),
(7,1,'2026-05-03 09:00:00','Febre',140.00,'concluida'),
(8,2,'2026-05-03 10:00:00','Ferimento na asa',220.00,'em_atendimento'),
(9,1,'2026-05-03 11:00:00','Troca de água inadequada',100.00,'concluida'),
(10,3,'2026-05-04 09:00:00','Problema respiratório',350.00,'cancelada'),
(11,1,'2026-05-04 10:00:00','Check-up',150.00,'concluida'),
(12,2,'2026-05-04 11:00:00','Dermatite',210.00,'concluida'),
(13,1,'2026-05-05 09:00:00','Vacinação',120.00,'agendada'),
(14,2,'2026-05-05 10:00:00','Avaliação',170.00,'concluida'),
(15,3,'2026-05-05 11:00:00','Exame geral',400.00,'em_atendimento'),
(1,1,'2026-05-06 09:00:00','Retorno',100.00,'agendada'),
(2,2,'2026-05-06 10:00:00','Tratamento contínuo',190.00,'concluida'),
(3,3,'2026-05-06 11:00:00','Cirurgia',800.00,'agendada'),
(4,1,'2026-05-07 09:00:00','Exame de rotina',130.00,'concluida'),
(5,2,'2026-05-07 10:00:00','Consulta dermatológica',210.00,'cancelada');

INSERT INTO pagamentos
(consulta_id, valor_pago, forma_pagamento, data_pagamento, status)
VALUES
(1,150.00,'pix','2026-05-01','pago'),
(2,200.00,'cartao','2026-05-01','pago'),
(3,500.00,'pix','2026-05-01','pago'),
(4,120.00,'dinheiro','2026-05-02','pago'),
(5,180.00,'cartao','2026-05-02','pago'),
(6,300.00,'convenio','2026-05-02','pendente'),
(7,140.00,'pix','2026-05-03','pago'),
(8,220.00,'cartao','2026-05-03','pendente'),
(9,100.00,'dinheiro','2026-05-03','pago'),
(10,350.00,'pix','2026-05-04','cancelado'),
(11,150.00,'pix','2026-05-04','pago'),
(12,210.00,'cartao','2026-05-04','pago'),
(13,120.00,'convenio','2026-05-05','pendente'),
(14,170.00,'dinheiro','2026-05-05','pago'),
(15,400.00,'pix','2026-05-05','pendente'),
(16,100.00,'cartao','2026-05-06','pendente'),
(17,190.00,'pix','2026-05-06','pago'),
(18,800.00,'convenio','2026-05-06','pendente'),
(19,130.00,'dinheiro','2026-05-07','pago'),
(20,210.00,'cartao','2026-05-07','cancelado');
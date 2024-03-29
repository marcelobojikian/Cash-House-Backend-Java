
DROP TABLE IF EXISTS DASHBOARD_CASHIER;
DROP TABLE IF EXISTS DASHBOARD_GUEST;
DROP TABLE IF EXISTS DASHBOARD_TRANSACTION;
DROP TABLE IF EXISTS DASHBOARD;
DROP TABLE IF EXISTS TRANSACTION;
DROP TABLE IF EXISTS CASHIER;
DROP TABLE IF EXISTS FLATMATE;
DROP TABLE IF EXISTS LANGUAGE;

CREATE TABLE IF NOT EXISTS FLATMATE (
	ID BIGINT PRIMARY KEY AUTO_INCREMENT(1001,1),
	EMAIL VARCHAR(255) UNIQUE,
	NICKNAME VARCHAR(255),
	FIRST_STEP BOOLEAN,
	GUEST_STEP BOOLEAN
);

CREATE TABLE IF NOT EXISTS DASHBOARD (
	ID BIGINT PRIMARY KEY AUTO_INCREMENT(1001,1),
	OWNER_ID BIGINT,
	FOREIGN KEY (OWNER_ID) REFERENCES FLATMATE(ID)
);

CREATE TABLE IF NOT EXISTS CASHIER (
	ID BIGINT PRIMARY KEY AUTO_INCREMENT(1001,1),
	NAME VARCHAR(200),
	BALANCE DECIMAL(12,2),
	STARTED DECIMAL(12,2),
	OWNER_ID BIGINT,
	FOREIGN KEY (OWNER_ID) REFERENCES FLATMATE(ID)
);

CREATE TABLE IF NOT EXISTS TRANSACTION (
	ID BIGINT PRIMARY KEY AUTO_INCREMENT(1001,1),
	CREATE_BY_ID BIGINT,
	ASSIGNED_ID BIGINT,
	CASHIER_ID BIGINT,
	STATUS VARCHAR(20),
	ACTION VARCHAR(20),
	VALUE DECIMAL(12,2),
	CREATED_AT TIMESTAMP(26, 6),
	UPDATED_AT TIMESTAMP(26, 6),
	FOREIGN KEY (CREATE_BY_ID) REFERENCES FLATMATE(ID),
	FOREIGN KEY (ASSIGNED_ID) REFERENCES FLATMATE(ID),
	FOREIGN KEY (CASHIER_ID) REFERENCES CASHIER(ID)
);

CREATE TABLE IF NOT EXISTS DASHBOARD_CASHIER (
	ID_DASHBOARD BIGINT,
	ID_CASHIER BIGINT,
	FOREIGN KEY (ID_DASHBOARD) REFERENCES DASHBOARD(ID),
	FOREIGN KEY (ID_CASHIER) REFERENCES CASHIER(ID),
);

CREATE TABLE IF NOT EXISTS DASHBOARD_GUEST (
	ID_DASHBOARD BIGINT,
	ID_FLATMATE BIGINT,
	FOREIGN KEY (ID_DASHBOARD) REFERENCES DASHBOARD(ID),
	FOREIGN KEY (ID_FLATMATE) REFERENCES FLATMATE(ID),
);

CREATE TABLE IF NOT EXISTS DASHBOARD_TRANSACTION (
	ID_DASHBOARD BIGINT,
	ID_TRANSACTION BIGINT,
	FOREIGN KEY (ID_DASHBOARD) REFERENCES DASHBOARD(ID),
	FOREIGN KEY (ID_TRANSACTION) REFERENCES TRANSACTION(ID),
);

CREATE TABLE IF NOT EXISTS LANGUAGE (
	ID BIGINT PRIMARY KEY AUTO_INCREMENT(1001,1),
	LOCALE VARCHAR(5), 
	MESSAGE_KEY VARCHAR(255),
	MESSAGE_CONTENT VARCHAR(255)
);

INSERT INTO FLATMATE (ID, NICKNAME, EMAIL, FIRST_STEP, GUEST_STEP) VALUES (1, 'Marcelo (test)', 'marcelo@mail.com', false, false);
INSERT INTO FLATMATE (ID, NICKNAME, EMAIL, FIRST_STEP, GUEST_STEP) VALUES (2, 'Biro (test)', 'biro@mail.com', false, false);
INSERT INTO FLATMATE (ID, NICKNAME, EMAIL, FIRST_STEP, GUEST_STEP) VALUES (3, 'Eduardo (test)', 'eduardo@mail.com', false, false);
INSERT INTO FLATMATE (ID, NICKNAME, EMAIL, FIRST_STEP, GUEST_STEP) VALUES (4, 'Willian (test)', 'will@mail.com', false, false);
INSERT INTO FLATMATE (ID, NICKNAME, EMAIL, FIRST_STEP, GUEST_STEP) VALUES (5, 'Gabriela (test)', 'gabi@mail.com', false, false);
INSERT INTO FLATMATE (ID, NICKNAME, EMAIL, FIRST_STEP, GUEST_STEP) VALUES (6, 'Carol (test)', 'carol@mail.com', false, false);
INSERT INTO FLATMATE (ID, NICKNAME, EMAIL, FIRST_STEP, GUEST_STEP) VALUES (7, 'Raissa (test)', 'rai@mail.com', false, false);
INSERT INTO FLATMATE (ID, NICKNAME, EMAIL, FIRST_STEP, GUEST_STEP) VALUES (8, 'Jean (test)', 'jean@mail.com', false, false);
INSERT INTO FLATMATE (ID, NICKNAME, EMAIL, FIRST_STEP, GUEST_STEP) VALUES (9, 'Gretchen (test)', 'gretchen@mail.com', false, false);
INSERT INTO FLATMATE (ID, NICKNAME, EMAIL, FIRST_STEP, GUEST_STEP) VALUES (10, 'Fernando (test)', 'fernando@mail.com', false, false);

INSERT INTO DASHBOARD (ID, OWNER_ID) VALUES (1, 1);
INSERT INTO DASHBOARD (ID, OWNER_ID) VALUES (2, 8);

INSERT INTO CASHIER (ID, OWNER_ID, BALANCE, NAME, STARTED) VALUES (1, 1, 32.54, 'Energy & bin', 0);
INSERT INTO CASHIER (ID, OWNER_ID, BALANCE, NAME, STARTED) VALUES (2, 1, 120, 'Geral', 23);
INSERT INTO CASHIER (ID, OWNER_ID, BALANCE, NAME, STARTED) VALUES (3, 8, 3.11, 'Rent & Clean', 12.45);
			  
INSERT INTO DASHBOARD_CASHIER (ID_DASHBOARD, ID_CASHIER) VALUES (1, 1);
INSERT INTO DASHBOARD_CASHIER (ID_DASHBOARD, ID_CASHIER) VALUES (1, 2);
INSERT INTO DASHBOARD_CASHIER (ID_DASHBOARD, ID_CASHIER) VALUES (2, 3);
			  
INSERT INTO DASHBOARD_GUEST (ID_DASHBOARD, ID_FLATMATE) VALUES (1, 2);
INSERT INTO DASHBOARD_GUEST (ID_DASHBOARD, ID_FLATMATE) VALUES (1, 3);
INSERT INTO DASHBOARD_GUEST (ID_DASHBOARD, ID_FLATMATE) VALUES (1, 4);
INSERT INTO DASHBOARD_GUEST (ID_DASHBOARD, ID_FLATMATE) VALUES (1, 5);
INSERT INTO DASHBOARD_GUEST (ID_DASHBOARD, ID_FLATMATE) VALUES (1, 6);
INSERT INTO DASHBOARD_GUEST (ID_DASHBOARD, ID_FLATMATE) VALUES (1, 7);
INSERT INTO DASHBOARD_GUEST (ID_DASHBOARD, ID_FLATMATE) VALUES (2, 9);
INSERT INTO DASHBOARD_GUEST (ID_DASHBOARD, ID_FLATMATE) VALUES (2, 10);

-- Usuario Marcelo pertence a dois dashboard
INSERT INTO DASHBOARD_GUEST (ID_DASHBOARD, ID_FLATMATE) VALUES (2, 1);

INSERT INTO TRANSACTION (ID, CREATE_BY_ID, ASSIGNED_ID, CASHIER_ID, STATUS, ACTION, VALUE, CREATED_AT) VALUES (1, 1, 1, 1, 'CREATED', 'DEPOSIT', 1.99, '2020-01-28 23:59:59');
INSERT INTO TRANSACTION (ID, CREATE_BY_ID, ASSIGNED_ID, CASHIER_ID, STATUS, ACTION, VALUE, CREATED_AT) VALUES (2, 1, 2, 1, 'FINISHED', 'WITHDRAW', 23, '2020-01-27 23:59:59');
INSERT INTO TRANSACTION (ID, CREATE_BY_ID, ASSIGNED_ID, CASHIER_ID, STATUS, ACTION, VALUE, CREATED_AT) VALUES (3, 1, 4, 2, 'SENDED', 'WITHDRAW', 5.53, '2020-01-28 23:59:59');
INSERT INTO TRANSACTION (ID, CREATE_BY_ID, ASSIGNED_ID, CASHIER_ID, STATUS, ACTION, VALUE, CREATED_AT) VALUES (4, 5, 5, 2, 'CREATED', 'DEPOSIT', 12.03, '2020-01-28 23:59:59');
INSERT INTO TRANSACTION (ID, CREATE_BY_ID, ASSIGNED_ID, CASHIER_ID, STATUS, ACTION, VALUE, CREATED_AT) VALUES (5, 6, 6, 2, 'CANCELED', 'DEPOSIT', 66.11, '2020-01-27 23:59:59');
INSERT INTO TRANSACTION (ID, CREATE_BY_ID, ASSIGNED_ID, CASHIER_ID, STATUS, ACTION, VALUE, CREATED_AT) VALUES (6, 1, 3, 1, 'DELETED', 'DEPOSIT', 61.30, '2020-01-28 23:59:59');
INSERT INTO TRANSACTION (ID, CREATE_BY_ID, ASSIGNED_ID, CASHIER_ID, STATUS, ACTION, VALUE, CREATED_AT) VALUES (7, 8, 8, 3, 'SENDED', 'WITHDRAW', 1.50, '2020-01-28 23:59:59');
INSERT INTO TRANSACTION (ID, CREATE_BY_ID, ASSIGNED_ID, CASHIER_ID, STATUS, ACTION, VALUE, CREATED_AT) VALUES (8, 8, 9, 3, 'CANCELED', 'DEPOSIT', 8.88, '2020-01-28 23:59:59');
INSERT INTO TRANSACTION (ID, CREATE_BY_ID, ASSIGNED_ID, CASHIER_ID, STATUS, ACTION, VALUE, CREATED_AT) VALUES (9, 10, 10, 3, 'CREATED', 'WITHDRAW', 9.41, '2020-01-28 23:59:59');
INSERT INTO TRANSACTION (ID, CREATE_BY_ID, ASSIGNED_ID, CASHIER_ID, STATUS, ACTION, VALUE, CREATED_AT) VALUES (10, 9, 9, 3, 'SENDED', 'DEPOSIT', 20, '2020-01-28 23:59:59');


INSERT INTO TRANSACTION (ID, CREATE_BY_ID, ASSIGNED_ID, CASHIER_ID, STATUS, ACTION, VALUE, CREATED_AT) VALUES (11, 1, 5, 2, 'CREATED', 'DEPOSIT', 12.03, '2020-01-28 23:59:59');
INSERT INTO TRANSACTION (ID, CREATE_BY_ID, ASSIGNED_ID, CASHIER_ID, STATUS, ACTION, VALUE, CREATED_AT) VALUES (22, 5, 1, 2, 'CREATED', 'DEPOSIT', 12.03, '2020-01-28 23:59:59');


INSERT INTO DASHBOARD_TRANSACTION (ID_DASHBOARD, ID_TRANSACTION) VALUES (1, 1);
INSERT INTO DASHBOARD_TRANSACTION (ID_DASHBOARD, ID_TRANSACTION) VALUES (1, 2);
INSERT INTO DASHBOARD_TRANSACTION (ID_DASHBOARD, ID_TRANSACTION) VALUES (1, 3);
INSERT INTO DASHBOARD_TRANSACTION (ID_DASHBOARD, ID_TRANSACTION) VALUES (1, 4);
INSERT INTO DASHBOARD_TRANSACTION (ID_DASHBOARD, ID_TRANSACTION) VALUES (1, 5);
INSERT INTO DASHBOARD_TRANSACTION (ID_DASHBOARD, ID_TRANSACTION) VALUES (1, 6);
INSERT INTO DASHBOARD_TRANSACTION (ID_DASHBOARD, ID_TRANSACTION) VALUES (2, 7);
INSERT INTO DASHBOARD_TRANSACTION (ID_DASHBOARD, ID_TRANSACTION) VALUES (2, 8);
INSERT INTO DASHBOARD_TRANSACTION (ID_DASHBOARD, ID_TRANSACTION) VALUES (2, 9);
INSERT INTO DASHBOARD_TRANSACTION (ID_DASHBOARD, ID_TRANSACTION) VALUES (2, 10);


INSERT INTO DASHBOARD_TRANSACTION (ID_DASHBOARD, ID_TRANSACTION) VALUES (1, 11);
INSERT INTO DASHBOARD_TRANSACTION (ID_DASHBOARD, ID_TRANSACTION) VALUES (1, 22);


INSERT INTO LANGUAGE (LOCALE, MESSAGE_KEY, MESSAGE_CONTENT) VALUES
('en', 'cashier.not.found','Cashier {0} not found'),
('en', 'flatmate.not.found', 'Flatmate {0} not found'),
('en', 'transaction.not.found', 'Transaction {0} not found'),
('en', 'transaction.status.invalid.operation', 'Invalid operation, Transaction {0} with status equal to {1}'),
('en', 'flatmate.access.denied', 'Flatmate {0} does not have permissions for the resource'),
('en', 'flatmate.access.field.denied', 'Flatmate {0} does not have permissions for field {1}'),
('en', 'flatmate.assigned.not.found', 'Flatmate assigned {0} not found'),
('en', 'flatmate.createBy.not.found', 'Flatmate createBy {0} not found'),

('pt', 'cashier.not.found','Caixinha {0} não encontrada'),
('pt', 'flatmate.not.found', 'Flatmate {0} não encontrado'),
('pt', 'transaction.not.found', 'Transação {0} não encontrada'),
('pt', 'transaction.status.invalid.operation', 'Operação invalid, Transação {0} com status igual a {1}'),
('pt', 'flatmate.access.denied', 'Flatmate {0} não tem permissão para esse recurso'),
('pt', 'flatmate.access.field.denied', 'Flatmate {0} não tem permissão para o recurso {1}'),
('pt', 'flatmate.assigned.not.found', 'Flatmate assinado {0} não encontrado para a Transação'),
('pt', 'flatmate.createBy.not.found', 'Flatmate criador {0} não encontrado para a Transação'),

('es', 'cashier.not.found','Cashier {0} not found'),
('es', 'flatmate.not.found', 'Flatmate {0} not found'),
('es', 'transaction.not.found', 'Transaction {0} not found'),
('es', 'transaction.status.invalid.operation', 'Invalid operation, Transaction {0} with status equal to {1}'),
('es', 'flatmate.access.denied', 'Flatmate {0} does not have permissions for the resource'),
('es', 'flatmate.access.field.denied', 'Flatmate {0} does not have permissions for field {1}'),
('es', 'flatmate.assigned.not.found', 'Flatmate assigned {0} not found'),
('es', 'flatmate.createBy.not.found', 'Flatmate createBy {0} not found');


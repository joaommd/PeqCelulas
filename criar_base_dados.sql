USE db_peqcelulas;
DROP 
  TABLE IF EXISTS demograficos; 
CREATE TABLE demograficos(
  doente_id INT AUTO_INCREMENT PRIMARY KEY, 
  nd INT NOT NULL, 
  data_nascimento DATE, 
  genero VARCHAR (10), 
  CONSTRAINT genero_chk CHECK (
    genero IN ('Feminino', 'Masculino', 'Outro')
  ), 
  PRIMARY KEY (doente_id)
);
DROP 
  TABLE IF EXISTS diagnosticos;
CREATE TABLE diagnosticos(
  doente_id INT NOT NULL, 
  data_diagnostico DATE NOT NULL, 
  topografia VARCHAR(10) NOT NULL, 
  histologia VARCHAR(10) NOT NULL, 
  comportamento INT, 
  grau INT, 
  lateralidade VARCHAR(20), 
  CONSTRAINT diagn_prmkey PRIMARY KEY (
    doente_id, data_diagnostico, topografia, 
    histologia
  ), 
  CONSTRAINT lateralidade_chk CHECK (
    lateralidade IN (
      'Direito', 'Esquerdo', 'Central', 
      'Desconhecido'
    )
  ),
	CONSTRAINT diagn_frkey FOREIGN KEY (doente_id) REFERENCES demograficos(doente_id)
    );
DROP 
  TABLE IF EXISTS estadios;
CREATE TABLE estadios(
  doente_id INT NOT NULL, 
  tipo VARCHAR(12) NOT NULL, 
  data DATE NOT NULL, 
  T VARCHAR(3) NOT NULL, 
  N VARCHAR(3) NOT NULL, 
  M VARCHAR(3) NOT NULL, 
  agrupado VARCHAR(4), 
  CONSTRAINT tipo_chk CHECK (
    tipo IN ('Clínico', 'Patológico')
  ), 
  PRIMARY KEY (doente_id, data, tipo), 
  FOREIGN KEY (doente_id) REFERENCES demograficos(doente_id)
);
DROP 
  TABLE IF EXISTS actos_medicos;
CREATE TABLE actos_medicos(
  doente_id INT NOT NULL, 
  tipo_ato VARCHAR(20) NOT NULL, 
  grupo_ato VARCHAR(20) NOT NULL, 
  servico_executante VARCHAR(10) NOT NULL, 
  data_acto DATE NOT NULL, 
  estado VARCHAR (5), 
  CONSTRAINT estado_chk CHECK (
    estado IN (
      'VSEC', 'VCEC', 'VXEC', 'MSEC', 'MCEC', 
      'MXEC'
    )
  ), 
  FOREIGN KEY (doente_id) REFERENCES demograficos(doente_id)
);
DROP 
  TABLE IF EXISTS biometrias;
CREATE TABLE biometrias(
  doente_id INT NOT NULL, 
  data_hora TIMESTAMP NOT NULL, 
  tipo VARCHAR(255) NOT NULL, 
  valor FLOAT NOT NULL, 
  unidades VARCHAR(20) NOT NULL, 
  PRIMARY KEY (doente_id, data_hora, tipo), 
  FOREIGN KEY (doente_id) REFERENCES demograficos(doente_id)
);
DROP 
  TABLE IF EXISTS ref_medicamentos;
CREATE TABLE ref_medicamentos(
  codigo_medicamento VARCHAR (10) PRIMARY KEY, 
  nome_medicamento VARCHAR(10)
);
DROP 
  TABLE IF EXISTS ref_protocolos;
CREATE TABLE ref_protocolos(
  codigo_protocolo VARCHAR (10), 
  nome_protocolo VARCHAR(10), 
  PRIMARY KEY (
    codigo_protocolo, nome_protocolo
  )
);
DROP 
  TABLE IF EXISTS farmacos;
CREATE TABLE farmacos(
  doente_id INT NOT NULL, 
  data_administracao DATE NOT NULL, 
  grupo_farmacoter VARCHAR(10), 
  codigo_medicamento VARCHAR(10) NOT NULL, 
  local_administracao VARCHAR(10), 
  codigo_protocolo VARCHAR(10), 
  CONSTRAINT localadmn_chk CHECK (
    local_administracao IN (
      'Internamento', 'Hospital Dia', 'Ambulatório'
    )
  ), 
  PRIMARY KEY (
    doente_id, data_administracao, codigo_medicamento
  ), 
  FOREIGN KEY (doente_id) REFERENCES demograficos(doente_id), 
  FOREIGN KEY (codigo_medicamento) REFERENCES ref_medicamentos(codigo_medicamento)
);
DROP 
  TABLE IF EXISTS adiamentos;
CREATE TABLE adiamentos(
  doente_id INT NOT NULL, 
  data_adiamento DATE NOT NULL, 
  motivo VARCHAR(10), 
  PRIMARY KEY (doente_id, data_adiamento), 
  FOREIGN KEY (doente_id) REFERENCES demograficos(doente_id)
);
DROP 
  TABLE IF EXISTS radioterapia;
CREATE TABLE radioterapia(
  doente_id INT NOT NULL, 
  data_procedimento DATE NOT NULL, 
  procedimento VARCHAR(10) NOT NULL, 
  PRIMARY KEY (
    doente_id, data_procedimento, procedimento
  )
);
DROP 
  TABLE IF EXISTS ref_radioterapia;
CREATE TABLE ref_radioterapia (
    procedimento VARCHAR(10) PRIMARY KEY,
    tipo VARCHAR(10) NOT NULL,
    CONSTRAINT tipo_chk CHECK (tipo IN ('convencional' , 'estereotáxica'))
);

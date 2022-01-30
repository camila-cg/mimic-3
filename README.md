# Projeto de Aplicação: Análise exploratória da base MIMIC-III.
---

## Objetivo
Para este trabalho foi utilizada a base do MIMIC-III, cuja documentação está disponível no site https://mimic.mit.edu/docs/iii/. O objetivo desta análise exploratória é compreender as principais características da base do MIMIC-III, que é uma base muito relevante para estudo de doenças e criação de modelos.

## A base MIMIC-III
 O MIMIC (Medical Information Mart for Intensive Care) é uma base de dados médicos de pacientes do hospital Beth Israel Deaconess Medical Center, localizado em Boston, nos Estados Unidos. O acesso aos dados é gratuito e cedido pela PhysioNet. Nesta versão da base MIMIC temos atendimentos efetuados de **01/06/2001** a **10/10/2012**, contendo **58.976** atendimentos e possuindo **46.520** pacientes.

### Dados selecionados
A base possui 26 tabelas, mas apenas as principais tabelas serão exploradas neste trabalho, que são elas:
- A tabela de pacientes (patients),
- A tabela de atendimentos (admissions),
- A tabela de serviços (services),
- A tabela de atendimentos da UTI (icu_stays),
- A tabela de diagnósticos (diagnoses) e
- A tabela contendo o dicionário dos diagnósticos (d_icd_diagnoses)

Para cada tabela foram selecionados os dados mais relevantes, também sendo criadas views e queries auxiliares para a junção de dados a fim de otimizar a manipulação através da linguagem Python e suas bibliotecas, listadas na seção seguinte. Os códigos em SQL também são disponibilizados neste repositório.

Essa base de dados possui pontos interessantes a serem mencionados. O primeiro deles é de que não temos um atributo com a idade dos pacientes, apenas as datas de nascimento, atendimento em questão e morte. Então para análises por faixa etária já surgiu este primeiro obstáculo. Ainda sobre as idades dos pacientes, as datas não são reais, foram alteradas tanto para datas do passado quanto para datas do futuro, de modo a anonimizar ao máximo estes pacientes. De forma mais específica, os pacientes acima de 89 anos tiveram as suas datas alteradas de modo que ao calcularmos a sua idade no primeiro atendimento todos têm 300 anos, haja vista que possivelmente existem pacientes em idade avançada, onde o reconhecimento, ainda que difícil, seria possível. 

Outro ponto importante sobre os pacientes e que chamou a minha atenção são as informações demográficas, que são estado civil, grupo étnico, religião e língua estarem atrelados ao atendimento e não ao paciente de forma direta. Percebe-se na base que dentre os pacientes que passaram mais de uma vez no hospital, que equivale a cerca de 1/5 do total, algumas dessas informações mudaram, como estado civil, qu é uma mudança aceitável mas outras nem tanto, como grupo étnico, dado que é uma informação que não deveria mudar. 

## Bibliotecas utilizadas
Foram utilizadas as seguintes bibliotecas:
- pandas
- matplotlib
- seaborn

## Conclusões
 A partir da análise exploratória, foi possível verificar as principais características dos pacientes, quais são os dados dos atendimentos e quais grupos são interessantes serem vistos de forma mais aprofundada. Um exemplo é que doenças cardíacas são muito comuns dentre os diagnósticos dos pacientes, então talvez seja interessante buscar mais relacionamentos entre os dados de pacientes com este histórico, a fim de buscar mais semelhanças entre eles em dados de exames e sensores de UTI. 
 A parte de diagnóstico é uma informação desafiadora, porque ao contrário do que eu esperava cada paciente possui diversas anotações de diagnóstico e nem todos estão presentes na tabela que contém o mapeamento dos códigos destas doenças. Além disso, na tabela de atendimentos temos um campo de texto livre sobre o diagnóstico, que contém as mais diversas descrições, desde informações médicas muito precisas até a sintomas vagos como 'weakness' (ou fraqueza me português). Uma possibilidade de estudo futuro seria aplicar técnicas de Processamento de Linguagem Natural para entender como podemos classificar as doenças dos pacientes e encontrar padrões entre elas.
 Além do desafio de explorar os diagnósticos existem outros dados cuja análise requer um tratamento maior, como as informações demográficas. Para cada uma delas existe uma variação muito grande de mnemônicos e alguns deles incompreensíveis. Se houvesse um agrupamento poderiam ser feitas análises mais aprofundadas objetivando entender o que leva cada um destes grupos a procurar o hospital e se alguma doença tem maior predisposição em determinado grupo desta população.
 Existem muitos outros dados que podem ser explorados em etapas futuras, como os da tabela *chartevents*, que possui os dados dos sensores dos pacientes na UTI, assim como os dados de exames laboratorais (presentes em *labevents*), mas esses a análise seria mais eficaz com o apoio de um especialista de domínio para uma investigação mais direcionada.


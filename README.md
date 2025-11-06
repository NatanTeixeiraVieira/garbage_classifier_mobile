# Projeto de Classificação de Lixo com IA

## Estrutura Inicial e Layout Base

Este projeto consistem em um aplicativo de celular para auxiliar na classificação de lixo utilizando inteligência artificial e a câmera do dispositivo. A ideia é que o usuário escaneie o material e o aplicativo diga qual o tipo de material é aquele (plástico, vidro papel e afins), facilitando o descarte correto de materiais recicláveis e não recicláveis.

Para a utilização do software, será necessário a realização do cadastro e do login, para que, futuramente, sejam implementados funcionalidades analíticas para que o usuário possa visualizar um histórico dos materias escaneados, mostrar dados personalizados, entre outras funções. Por isso, foi adicionado telas de cadastro e login

Outra tela implementada foi a inicial, que conterá um botão para abrir a câmera do dispositivo e escanear o material a ser descartado.

## UI/UX Básico, Consumo de API e Validação de Formulários

O projeto passou por uma refatoração inicial de UI/UX, aplicando princípios como Atomic Design, onde os widgets foram organizados em átomos, moléculas e organismos, tornando widgets reutilizáveis e facilitando a manutenção do código. Foram incluídas microinterações, como animações e feedback visual ao interagir com elementos da interface, utilizando InkWell e GestureDetector, modificando a escala dos botões de login e cadastro quando eles são pressionados.

Além disso, também foram consideradas práticas básicas de acessibilidade, como o uso de Semantics em elementos importantes, permitindo melhor navegação para usuários de leitores de tela. Fora isso, o sistema integra uma API pública que traz o endereço do usuário com base em seu CEP, preenchendo os demais campos. O aplicativo tem formulários contendo e validação de todos os campo a fim de garantir que os campos estejam preenchidos corretamente antes do envio, utilizando os validadores do Flutter.

Ademais, foi implementado um banco de dados local para salvar o cadastro de usuário e fazer login verifiando os dados salvos

Adapte o readme para que os pontos cobrados fiquem claros para o professor:

Entrega Parcial 1: Arquitetura, Gerenciamento de Estado Avançado e Testes Básicos
(Valor: 30% da Nota Final da Etapa Final)
• Prazo: 07/11
• O que deve ser entregue:
o Repositório Git Atualizado: Com as implementações das funcionalidades
abaixo.
o Refatoração para Arquitetura: Reestruturação de pelo menos um módulo
ou funcionalidade principal da aplicação para seguir um padrão de
arquitetura como MVVM ou princípios da Clean Architecture (separação
de camadas: UI, Domain, Data).
o Gerenciamento de Estado Avançado: Migração do gerenciamento de
estado para uma solução mais robusta (ex: Provider, Riverpod, ou
Bloc/Cubit).
o Testes Automatizados:
▪ Implementação de testes unitários para a lógica de negócio mais
importante (ex: modelos, serviços, validações).
▪ Implementação de testes de widget para um componente UI
complexo, verificando seu comportamento.

• Avaliação: Será avaliada a compreensão e aplicação dos padrões de arquitetura, a
migração para um gerenciamento de estado mais robusto com DI, e a qualidade e
relevância dos testes automatizados implementados.

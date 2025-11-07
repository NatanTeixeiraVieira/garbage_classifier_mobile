# Projeto de Classificação de Lixo com IA

Este projeto consiste em um aplicativo móvel que auxilia na classificação de lixo utilizando inteligência artificial e a câmera do dispositivo. O usuário pode escanear um material e o aplicativo sugere o tipo de material (plástico, vidro, papel, entre outros), facilitando o descarte correto e a reciclagem. Para utilizar o app, o usuário realiza cadastro e login; isso permite, em etapas futuras, funcionalidades analíticas e um histórico dos materiais escaneados, além de dados personalizados. Além das telas de autenticação, existe uma tela inicial com um botão para abrir a câmera e escanear o material a ser descartado.

Com o intuito de manter o código estruturado, foi aplicada uma organização arquitetural que separa claramente as responsabilidades de apresentação, domínio e dados, com os casos de uso (usecases) encapsulando a lógica de negócio e interfaces de repositório definindo contratos entre camadas. A injeção de dependências foi centralizada em `lib/injection.dart` utilizando a biblioteca `get_it`, o que facilita a troca de implementações e torna os componentes testáveis. O gerenciamento de estado foi migrado para uma solução baseada em Cubits/Blocs (pacote `flutter_bloc`), permitindo um fluxo de dados previsível e testável nas telas principais, como login e câmera. Os arquivos que ilustram essas decisões estão em `lib/features/*/presentation` para UI e cubits, em `lib/features/*/domain` para entidades e usecases, e em `lib/features/*/data` para repositórios e datasources.

Em termos de testes automatizados, foi adicionado testes unitários que cobrem serviços e lógica crítica (por exemplo, hashing de senha e repositório de autenticação) e testes de widget que verificam o comportamento de componentes de interface mais complexos. Para validar localmente, recomenda-se executar os comandos: primeiro `flutter pub get` para instalar dependências, em seguida `flutter test` para rodar a suíte de testes automatizados e, por fim, `flutter run` para inspecionar o aplicativo em um dispositivo ou emulador.

Para rodar o backend
Baixar a imagem: docker pull natanteixeiravieira/garbage-classifier-api
Rodar: docker run -itd -p 8000:8000 --name garbage-classifier-api
natanteixeiravieira/garbage-classifier-api

Com isso, o projeto roda na porta 8000 normalmente

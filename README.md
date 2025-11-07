# RGomes Store 🛒

Um aplicativo de e-commerce Flutter integrado com a plataforma VTEX, desenvolvido seguindo os princípios da Clean Architecture e utilizando as melhores práticas de desenvolvimento mobile.

## 📱 Sobre o Projeto

O RGomes Store é uma aplicação completa de e-commerce que permite aos usuários navegar por produtos, adicionar itens ao carrinho e realizar pedidos. O app consome dados da API VTEX e oferece uma experiência de compra moderna e intuitiva.

### ✨ Funcionalidades

- 📋 Listagem de produtos com filtros por categoria
- 🛒 Carrinho de compras com persistência local
- 📦 Histórico de pedidos
- 🎨 Interface moderna e responsiva
- 💾 Armazenamento local com Hive
- 🔄 Gerenciamento de estado reativo

## 🏗️ Arquitetura

O projeto foi desenvolvido seguindo os princípios da **Clean Architecture**, promovendo separação de responsabilidades, testabilidade e manutenibilidade.

### 📁 Estrutura de Pastas

```
lib/
├── core/                    # Funcionalidades compartilhadas
│   ├── http_client.dart     # Cliente HTTP customizado
│   └── theme/              # Sistema de design (cores, tipografia, tema)
├── data/                   # Camada de dados
│   ├── datasources/        # Fontes de dados (API, local)
│   ├── models/            # Modelos de dados
│   └── repositories/      # Implementação dos repositórios
├── domain/                # Regras de negócio
│   ├── entities/          # Entidades do domínio
│   ├── repositories/      # Contratos dos repositórios
│   └── usecases/         # Casos de uso
└── presentation/          # Interface do usuário
    ├── cubit/            # Gerenciamento de estado
    └── pages/            # Telas e widgets
```

### 🔄 Fluxo da Arquitetura

```
UI (Pages/Widgets) → Cubit → UseCase → Repository → DataSource → API/Local Storage
```

## 🛠️ Tecnologias Utilizadas

### Framework e Linguagem
- **Flutter** 3.9.2+ - Framework para desenvolvimento multiplataforma
- **Dart** 3.9.2+ - Linguagem de programação

### Gerenciamento de Estado
- **flutter_bloc** 8.1.6 - Implementação do padrão BLoC/Cubit para gerenciamento de estado reativo
- **Cubit** - Versão simplificada do BLoC para casos de uso mais diretos

### Requisições HTTP
- **http** 1.1.0 - Cliente HTTP para comunicação com APIs REST
- **HttpClient customizado** - Wrapper para configurações específicas da API VTEX

### Persistência de Dados
- **hive** 2.2.3 - Banco de dados NoSQL local, rápido e leve
- **hive_flutter** 1.1.0 - Integração do Hive com Flutter
- **hive_generator** 2.0.1 - Gerador de código para adapters do Hive

### Utilitários
- **path_provider** 2.1.1 - Acesso aos diretórios do sistema
- **uuid** 4.1.0 - Geração de identificadores únicos
- **build_runner** 2.4.7 - Ferramenta para geração de código

### Integração Externa
- **API VTEX** - Plataforma de e-commerce para catálogo de produtos

## 🎯 Padrões de Design Implementados

### 1. **Repository Pattern**
Abstração da camada de dados, permitindo trocar fontes de dados sem impactar a lógica de negócio.

### 2. **Dependency Injection**
Injeção de dependências manual no `main.dart`, facilitando testes e desacoplamento.

### 3. **State Management com Cubit**
- `ProductsCubit` - Gerencia produtos e filtros
- `CartCubit` - Controla o carrinho de compras
- `OrdersCubit` - Administra o histórico de pedidos

### 4. **Clean Architecture Layers**
- **Domain**: Entidades e regras de negócio puras
- **Data**: Implementações concretas e modelos
- **Presentation**: Interface e gerenciamento de estado

## 🚀 Como Executar

### Pré-requisitos
- Flutter SDK 3.9.2 ou superior
- Dart SDK 3.9.2 ou superior
- Android Studio / VS Code
- Emulador Android/iOS ou dispositivo físico

### Passos para execução

1. **Clone o repositório**
```bash
git clone https://github.com/seu-usuario/rgomes_store.git
cd rgomes_store
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Execute o build runner** (para gerar códigos do Hive)
```bash
flutter packages pub run build_runner build
```

4. **Execute o aplicativo**
```bash
flutter run
```

## 📊 Gerenciamento de Estado

O app utiliza o padrão **BLoC/Cubit** para gerenciamento de estado:

### Estados Principais

#### ProductsCubit
- `ProductsInitial` - Estado inicial
- `ProductsLoading` - Carregando produtos
- `ProductsLoaded` - Produtos carregados com sucesso
- `ProductsError` - Erro ao carregar produtos

#### CartCubit
- Gerencia itens do carrinho
- Persiste dados localmente com Hive
- Calcula totais automaticamente

#### OrdersCubit
- Mantém histórico de pedidos
- Salva pedidos no armazenamento local

## 🗄️ Persistência de Dados

### Hive Database
- **cartBox**: Armazena itens do carrinho
- **ordersBox**: Mantém histórico de pedidos
- **Performance**: Acesso rápido aos dados locais
- **Offline-first**: Funciona sem conexão

## 🎨 Sistema de Design

O app possui um sistema de design consistente com:
- **Cores personalizadas** (AppColors)
- **Tipografia padronizada** (AppTypography)  
- **Tema unificado** (AppTheme)
- **Componentes reutilizáveis**

## 🧪 Testes

O projeto está preparado para testes unitários e de widget:
- Estrutura para testes de unidade
- Mocks de repositórios
- Testes de Cubits

## 📈 Próximas Funcionalidades

- [ ] Autenticação de usuários
- [ ] Busca de produtos
- [ ] Favoritos
- [ ] Notificações push
- [ ] Modo escuro
- [ ] Internacionalização

## 👨‍💻 Desenvolvedor

**Rômulo Gomes**
- GitHub: [@seu-usuario](https://github.com/seu-usuario)
- LinkedIn: [Seu LinkedIn](https://linkedin.com/in/seu-perfil)

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

⭐ Se este projeto foi útil para você, considere deixar uma estrela!

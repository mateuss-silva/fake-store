# Fake Store 🏪

O aplicativo tem como objetivo mostrar produtos de uma loja fictícia. 

<div align="center">
<img src="/assets/images/prints/products.png" alt="Home" style="height: 450px; "/>
<img src="/assets/images/prints/list-with-favorites.png" alt="Home" style="height: 450px; "/>
<img src="/assets/images/prints/empty.png" alt="Home" style="height: 450px; "/>
<img src="/assets/images/prints/details.png" alt="Home" style="height: 450px; "/>
<img src="/assets/images/prints/favorites.png" alt="Home" style="height: 450px; "/>
</div>

### Testes de unidade

Nos testes de unidade foi utilizando o [Mocktail](https://pub.dev/packages/mocktail), biblioteca de teste que fornece uma sintaxe simples para criar mocks.


## Detalhes Técnicos

### API
O aplicativo foi viabilizado utilizada a API [Fake Store](https://fakestoreapi.com).

### Arquitetura

O aplicativo foi desenvolvido utilizando Clean Architecture. 

### Gerenciamento de estado
Como gerenciamento de estado foi utilizado ValueNotifier com StatePattern, para que o estado seja notificado apenas quando houver alteração.

### Injeção de dependência: Modular;


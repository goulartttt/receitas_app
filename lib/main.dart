import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ReceitasApp());
}

class ReceitasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Receitas Fáceis',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

class Receita {
  final String nome; // Usado como ID para favoritos
  final String descricao;
  final String imagemUrl;
  final String categoria;
  final List<String> ingredientes;
  final String modoPreparo;

  Receita({
    required this.nome,
    required this.descricao,
    required this.imagemUrl,
    required this.categoria,
    required this.ingredientes,
    required this.modoPreparo,
  });
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // 0: Home, 1: Favoritos
  final List<Receita> _todasReceitas = _criarReceitas();
  Set<String> _favoritos = {}; // Conjunto de nomes das favoritas

  @override
  void initState() {
    super.initState();
    _carregarFavoritos();
  }

  // Função para criar as receitas (dados completos)
  static List<Receita> _criarReceitas() {
    return [
      // DOCES (5 receitas)
      Receita(
        nome: 'Bolo de Chocolate',
        descricao: 'Um bolo delicioso e fofinho de chocolate.',
        imagemUrl:
            'https://images.unsplash.com/photo-1578985545062-69928b1d9587',
        categoria: 'Doces',
        ingredientes: [
          '2 xícaras de farinha de trigo',
          '1 xícara de açúcar',
          '1 xícara de chocolate em pó',
          '3 ovos',
          '1 xícara de leite',
          '1/2 xícara de óleo',
          '1 colher de sopa de fermento em pó',
        ],
        modoPreparo: '''
1. Preaqueça o forno a 180°C.
2. Em uma tigela, misture a farinha, o açúcar e o chocolate em pó.
3. Adicione os ovos, o leite e o óleo, misturando bem.
4. Acrescente o fermento e misture delicadamente.
5. Despeje a massa em uma forma untada.
6. Asse por aproximadamente 35 minutos ou até que um palito saia limpo.
7. Deixe esfriar antes de desenformar.
''',
      ),
      Receita(
        nome: 'Brigadeiro Clássico',
        descricao: 'Brigadeiro tradicional brasileiro, cremoso e irresistível.',
        imagemUrl:
            'https://images.unsplash.com/photo-1574651351432-7e5e0a0e7e3a',
        categoria: 'Doces',
        ingredientes: [
          '1 lata de leite condensado',
          '1 colher de sopa de manteiga',
          '3 colheres de sopa de chocolate em pó',
          'Granulado de chocolate para enrolar',
        ],
        modoPreparo: '''
1. Em uma panela, misture o leite condensado, a manteiga e o chocolate em pó.
2. Leve ao fogo médio, mexendo sempre até desgrudar do fundo (cerca de 10 minutos).
3. Despeje em um prato untado e deixe esfriar.
4. Unte as mãos e enrole bolinhas.
5. Passe no granulado e sirva.
''',
      ),
      Receita(
        nome: 'Brownie de Nozes',
        descricao: 'Brownie úmido com pedaços de nozes para um toque crocante.',
        imagemUrl:
            'https://images.unsplash.com/photo-1606890658317-7d14490b76fd',
        categoria: 'Doces',
        ingredientes: [
          '200g de chocolate meio amargo',
          '1/2 xícara de manteiga',
          '1 xícara de açúcar',
          '2 ovos',
          '1 xícara de farinha de trigo',
          '1/2 xícara de nozes picadas',
          '1 colher de chá de essência de baunilha',
        ],
        modoPreparo: '''
1. Preaqueça o forno a 180°C.
2. Derreta o chocolate com a manteiga em banho-maria.
3. Misture o açúcar, ovos e baunilha até homogêneo.
4. Adicione a farinha e as nozes, incorporando bem.
5. Despeje em forma untada e asse por 25 minutos.
6. Deixe esfriar e corte em quadrados.
''',
      ),
      Receita(
        nome: 'Cookie de Chocolate',
        descricao: 'Cookies macios com gotas de chocolate para um lanche doce.',
        imagemUrl:
            'https://images.unsplash.com/photo-1571091718767-18b5b1457add',
        categoria: 'Doces',
        ingredientes: [
          '2 xícaras de farinha de trigo',
          '1 xícara de açúcar mascavo',
          '1/2 xícara de manteiga amolecida',
          '1 ovo',
          '1 xícara de gotas de chocolate',
          '1 colher de chá de fermento em pó',
          'Pitada de sal',
        ],
        modoPreparo: '''
1. Preaqueça o forno a 180°C.
2. Bata a manteiga com o açúcar até cremoso.
3. Adicione o ovo e misture.
4. Incorpore a farinha, fermento e sal.
5. Adicione as gotas de chocolate.
6. Forme bolinhas e asse por 10-12 minutos.
7. Deixe esfriar na grade.
''',
      ),
      Receita(
        nome: 'Doce de Leite Caseiro',
        descricao:
            'Doce de leite cremoso feito do zero, perfeito para recheios.',
        imagemUrl:
            'https://images.unsplash.com/photo-1606890658317-7d14490b76fd',
        categoria: 'Doces',
        ingredientes: [
          '1 lata de leite condensado',
          '1 colher de sopa de manteiga',
          'Pitada de bicarbonato de sódio',
        ],
        modoPreparo: '''
1. Em uma panela, misture o leite condensado, manteiga e bicarbonato.
2. Leve ao fogo médio, mexendo constantemente até engrossar (cerca de 15 minutos).
3. A cor deve ficar caramelo dourado.
4. Despeje em um pote esterilizado.
5. Deixe esfriar e armazene na geladeira.
''',
      ),
      // PRINCIPAIS (5 receitas)
      Receita(
        nome: 'Frango Assado',
        descricao: 'Frango temperado e assado até ficar dourado.',
        imagemUrl:
            'https://images.unsplash.com/photo-1600891964599-f61ba0e24092',
        categoria: 'Principais',
        ingredientes: [
          '1 frango inteiro (cerca de 1,5 kg)',
          '2 colheres de sopa de azeite',
          '2 dentes de alho picados',
          '1 colher de chá de páprica',
          '1 colher de chá de orégano seco',
          'Sal e pimenta a gosto',
          '1 limão (suco)',
          'Batatas e cenouras para acompanhar (opcional)',
        ],
        modoPreparo: '''
1. Preaqueça o forno a 200°C.
2. Tempere o frango por dentro e por fora com sal, pimenta, alho, páprica, orégano e suco de limão.
3. Regue com o azeite e massageie bem para incorporar os temperos.
4. Coloque o frango em uma assadeira e adicione as batatas e cenouras ao redor.
5. Asse por 1 hora e 30 minutos, regando com os sucos a cada 30 minutos.
6. Verifique se está cozido (temperatura interna de 75°C).
7. Deixe descansar por 10 minutos antes de fatiar.
''',
      ),
      Receita(
        nome: 'Macarrão ao Molho de Tomate',
        descricao: 'Macarrão simples com molho caseiro de tomate fresco.',
        imagemUrl:
            'https://images.unsplash.com/photo-1621996346565-e3dbc353d2e5',
        categoria: 'Principais',
        ingredientes: [
          '300g de macarrão espaguete',
          '4 tomates maduros',
          '2 dentes de alho',
          '1 cebola pequena',
          '2 colheres de sopa de azeite',
          'Manjericão fresco a gosto',
          'Sal e pimenta',
          'Queijo parmesão ralado (opcional)',
        ],
        modoPreparo: '''
1. Cozinhe o macarrão em água fervente com sal até al dente.
2. Em uma panela, refogue a cebola e alho no azeite.
3. Adicione os tomates picados e cozinhe por 15 minutos até formar molho.
4. Tempere com sal, pimenta e manjericão.
5. Misture o macarrão ao molho.
6. Sirva com parmesão por cima.
''',
      ),
      Receita(
        nome: 'Carne de Porco Grelhada',
        descricao: 'Bife de porco suculento grelhado com ervas.',
        imagemUrl:
            'https://images.unsplash.com/photo-1621996346565-e3dbc353d2e5',
        categoria: 'Principais',
        ingredientes: [
          '4 bifes de porco',
          '2 colheres de sopa de azeite',
          '2 dentes de alho',
          '1 colher de chá de alecrim',
          'Suco de 1 limão',
          'Sal e pimenta',
        ],
        modoPreparo: '''
1. Tempere os bifes com sal, pimenta, alho, alecrim e suco de limão.
2. Deixe marinar por 30 minutos.
3. Aqueça uma grelha ou frigideira com azeite.
4. Grelhe os bifes por 4-5 minutos de cada lado.
5. Deixe descansar antes de servir.
''',
      ),
      Receita(
        nome: 'Risoto de Cogumelos',
        descricao: 'Risoto cremoso com cogumelos frescos e parmesão.',
        imagemUrl:
            'https://images.unsplash.com/photo-1512568400610-3f3f73e26e1a',
        categoria: 'Principais',
        ingredientes: [
          '1 xícara de arroz arbóreo',
          '200g de cogumelos fatiados',
          '1 cebola picada',
          '2 dentes de alho',
          '4 xícaras de caldo de legumes',
          '1/2 xícara de queijo parmesão',
          '2 colheres de sopa de manteiga',
          'Vinho branco (opcional)',
        ],
        modoPreparo: '''
1. Refogue a cebola e alho na manteiga.
2. Adicione o arroz e toste por 2 minutos.
3. Acrescente os cogumelos e vinho, se usar.
4. Adicione o caldo aos poucos, mexendo até absorver (20 minutos).
5. Finalize com parmesão e manteiga.
6. Sirva quente.
''',
      ),
      Receita(
        nome: 'Peixe Assado com Ervas',
        descricao: 'Filé de peixe leve e saboroso assado com ervas frescas.',
        imagemUrl: 'https://images.unsplash.com/photo-1551218808-94e220e084d2',
        categoria: 'Principais',
        ingredientes: [
          '4 filés de peixe branco',
          '2 colheres de sopa de azeite',
          'Suco de 1 limão',
          'Ervas frescas (salsinha, tomilho)',
          '2 dentes de alho',
          'Sal e pimenta',
        ],
        modoPreparo: '''
1. Preaqueça o forno a 180°C.
2. Tempere os filés com sal, pimenta, alho, ervas e suco de limão.
3. Regue com azeite.
4. Coloque em assadeira e asse por 15-20 minutos.
5. Sirva com limão extra.
''',
      ),
      // SALADAS (3 receitas)
      Receita(
        nome: 'Salada Caesar',
        descricao: 'Salada clássica com alface, croutons e molho Caesar.',
        imagemUrl:
            'https://images.unsplash.com/photo-1568605114967-8130f3a36994',
        categoria: 'Saladas',
        ingredientes: [
          '1 cabeça de alface romana',
          '1/2 xícara de croutons',
          '1/4 xícara de queijo parmesão ralado',
          '2 filés de anchova',
          '1 dente de alho',
          '1 ovo',
          'Suco de 1 limão',
          '1/2 xícara de azeite de oliva',
          'Sal e pimenta a gosto',
        ],
        modoPreparo: '''
1. Lave e seque bem as folhas de alface, depois rasgue em pedaços.
2. No liquidificador, bata o alho, anchovas, ovo, suco de limão, sal e pimenta.
3. Adicione o azeite aos poucos até formar um molho cremoso.
4. Em uma tigela grande, misture a alface com o molho.
5. Polvilhe os croutons e o parmesão por cima.
6. Sirva imediatamente para manter a crocância.
''',
      ),
      Receita(
        nome: 'Salada de Quinoa',
        descricao: 'Salada nutritiva com quinoa, vegetais e molho de limão.',
        imagemUrl: 'https://images.unsplash.com/photo-1546793665-c9e9f9a9a8a5',
        categoria: 'Saladas',
        ingredientes: [
          '1 xícara de quinoa cozida',
          '1 pepino fatiado',
          '1 tomate picado',
          '1/2 abacate em cubos',
          'Folhas de espinafre',
          'Suco de 1 limão',
          '2 colheres de sopa de azeite',
          'Sal e ervas a gosto',
        ],
        modoPreparo: '''
1. Cozinhe a quinoa conforme instruções.
2. Em uma tigela, misture a quinoa com pepino, tomate, abacate e espinafre.
3. Tempere com suco de limão, azeite e sal.
4. Mexa bem e sirva fria.
''',
      ),
      Receita(
        nome: 'Salada Grega',
        descricao: 'Salada fresca com pepino, tomate, azeitonas e queijo feta.',
        imagemUrl:
            'https://images.unsplash.com/photo-1512499617640-c74ae3a79d37',
        categoria: 'Saladas',
        ingredientes: [
          '2 tomates',
          '1 pepino',
          '1 cebola roxa',
          '100g de queijo feta',
          '1/2 xícara de azeitonas',
          'Azeite e orégano',
          'Suco de limão',
          'Sal a gosto',
        ],
        modoPreparo: '''
1. Pique os tomates, pepino e cebola.
2. Em uma tigela, misture todos os ingredientes.
3. Tempere com azeite, limão, orégano e sal.
4. Deixe repousar por 10 minutos antes de servir.
''',
      ),
      // PÃES (2 receitas)
      Receita(
        nome: 'Pão Caseiro',
        descricao: 'Pão macio feito em casa, perfeito para o café da manhã.',
        imagemUrl: 'https://images.unsplash.com/photo-1542831371-d531d36971e6',
        categoria: 'Pães',
        ingredientes: [
          '500g de farinha de trigo',
          '1 colher de sopa de sal',
          '1 colher de sopa de açúcar',
          '7g de fermento biológico seco',
          '300ml de água morna',
          '2 colheres de sopa de azeite',
        ],
        modoPreparo: '''
1. Em uma tigela, misture a farinha, sal, açúcar e fermento.
2. Adicione a água morna e o azeite, misturando até formar uma massa.
3. Sove a massa por 10 minutos até ficar lisa e elástica.
4. Cubra e deixe fermentar em local quente por 1 hora, até dobrar de volume.
5. Desgase a massa, modele em forma de pão e coloque em uma assadeira.
6. Deixe descansar por mais 30 minutos.
7. Preaqueça o forno a 220°C e asse por 25-30 minutos até dourar.
8. Deixe esfriar em grade antes de cortar.
''',
      ),
      Receita(
        nome: 'Pão de Queijo',
        descricao:
            'Pão de queijo mineiro crocante por fora e macio por dentro.',
        imagemUrl:
            'https://images.unsplash.com/photo-1621996346565-e3dbc353d2e5',
        categoria: 'Pães',
        ingredientes: [
          '500g de polvilho azedo',
          '250ml de leite',
          '100ml de óleo',
          '2 ovos',
          '200g de queijo minas ralado',
          '1 colher de chá de sal',
        ],
        modoPreparo: '''
1. Ferva o leite com óleo e sal.
2. Despeje sobre o polvilho e misture.
3. Adicione os ovos e o queijo, amassando até homogêneo.
4. Forme bolinhas e coloque em assadeira.
5. Preaqueça o forno a 200°C e asse por 20-25 minutos até dourar.
6. Sirva quente.
''',
      ),
      // SOBREMESAS (3 receitas)
      Receita(
        nome: 'Mousse de Maracujá',
        descricao: 'Mousse refrescante de maracujá, leve e cremoso.',
        imagemUrl:
            'https://images.unsplash.com/photo-1574651351432-7e5e0a0e7e3a',
        categoria: 'Sobremesas',
        ingredientes: [
          '1 lata de leite condensado',
          '1 lata de creme de leite',
          '1/2 xícara de suco de maracujá',
          'Polpa de 2 maracujás para calda',
          '1/2 xícara de açúcar para calda',
        ],
        modoPreparo: '''
1. No liquidificador, bata o leite condensado, creme de leite e suco de maracujá até cremoso.
2. Despeje em taças e leve à geladeira por 2 horas.
3. Para a calda: Cozinhe a polpa com açúcar até engrossar.
4. Despeje a calda sobre o mousse gelado e sirva.
''',
      ),
      Receita(
        nome: 'Pudim de Leite',
        descricao: 'Pudim clássico brasileiro com calda de caramelo.',
        imagemUrl:
            'https://images.unsplash.com/photo-1606890658317-7d14490b76fd',
        categoria: 'Sobremesas',
        ingredientes: [
          '1 lata de leite condensado',
          '1 lata de leite (medida pela lata de condensado)',
          '3 ovos',
          '1 colher de chá de essência de baunilha',
          'Para a calda: 1 xícara de açúcar',
        ],
        modoPreparo: '''
1. Para a calda: Derreta o açúcar em panela até caramelo dourado, despeje em forma de pudim.
2. No liquidificador, bata o leite condensado, leite, ovos e baunilha.
3. Despeje sobre a calda na forma.
4. Asse em banho-maria a 180°C por 50 minutos.
5. Deixe esfriar e desenforme.
''',
      ),
      Receita(
        nome: 'Tiramisu Clássico',
        descricao: 'Tiramisu italiano com café, mascarpone e cacau.',
        imagemUrl:
            'https://images.unsplash.com/photo-1512568400610-3f3f73e26e1a',
        categoria: 'Sobremesas',
        ingredientes: [
          '200g de biscoito champanhe',
          '250g de mascarpone',
          '3 ovos (gemas e claras separadas)',
          '1/2 xícara de açúcar',
          '1 xícara de café forte',
          'Cacau em pó para polvilhar',
        ],
        modoPreparo: '''
1. Bata as gemas com metade do açúcar até cremoso.
2. Incorpore o mascarpone.
3. Bata as claras em neve com o restante do açúcar e misture delicadamente.
4. Molhe os biscoitos no café e alterne camadas com o creme em uma travessa.
5. Polvilhe cacau e leve à geladeira por 4 horas.
6. Sirva gelado.
''',
      ),
      // LANCHES (2 receitas)
      Receita(
        nome: 'Sanduíche de Atum',
        descricao: 'Sanduíche rápido e saudável com atum e vegetais.',
        imagemUrl: 'https://images.unsplash.com/photo-1551218808-94e220e084d2',
        categoria: 'Lanches',
        ingredientes: [
          '1 lata de atum em óleo (escorrida)',
          '2 colheres de sopa de maionese',
          '1 cenoura ralada',
          '4 fatias de pão integral',
          'Alface e tomate a gosto',
          'Sal e pimenta',
        ],
        modoPreparo: '''
1. Misture o atum com maionese, cenoura, sal e pimenta.
2. Recheie as fatias de pão com a mistura, alface e tomate.
3. Feche o sanduíche e sirva imediatamente.
4. Opcional: Grelhe levemente para tostar.
''',
      ),
      Receita(
        nome: 'Torta de Frango',
        descricao: 'Torta salgada prática para lanches ou refeições leves.',
        imagemUrl: 'https://images.unsplash.com/photo-1546793665-c9e9f9a9a8a5',
        categoria: 'Lanches',
        ingredientes: [
          'Massa: 2 xícaras de farinha, 100g de manteiga, 1 ovo, sal',
          'Recheio: 300g de frango cozido e desfiado',
          '1 cebola, 1 tomate, 1/2 xícara de milho',
          '1/2 xícara de requeijão cremoso',
          'Temperos a gosto',
        ],
        modoPreparo: '''
1. Para a massa: Misture farinha, manteiga, ovo e sal até formar uma massa. Abra em forma.
2. Refogue cebola, adicione frango, tomate, milho e temperos.
3. Misture o requeijão ao recheio.
4. Coloque o recheio na massa e cubra com outra camada de massa.
5. Asse a 180°C por 30-35 minutos até dourar.
6. Deixe esfriar e corte em porções.
''',
      ),
    ];
  }

  // Carregar favoritos do armazenamento local
  Future<void> _carregarFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritosString = prefs.getStringList('favoritos') ?? [];
    setState(() {
      _favoritos = favoritosString.toSet();
    });
  }

  // Salvar favoritos no armazenamento local
  Future<void> _salvarFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    final favoritosList = _favoritos.toList();
    await prefs.setStringList('favoritos', favoritosList);
  }

  // Toggle (adicionar/remover) favorita
  void _toggleFavorito(String nomeReceita) {
    setState(() {
      if (_favoritos.contains(nomeReceita)) {
        _favoritos.remove(nomeReceita);
      } else {
        _favoritos.add(nomeReceita);
      }
    });
    _salvarFavoritos();
    // Feedback visual
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _favoritos.contains(nomeReceita)
              ? 'Adicionada aos favoritos!'
              : 'Removida dos favoritos.',
        ),
        backgroundColor: _favoritos.contains(nomeReceita)
            ? Colors.red[400]
            : Colors.grey,
        duration: Duration(seconds: 1),
      ),
    );
  }

  // Verificar se é favorita
  bool _isFavorita(String nomeReceita) {
    return _favoritos.contains(nomeReceita);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _currentIndex == 0
          ? HomePage(
              todasReceitas: _todasReceitas,
              favoritos: _favoritos,
              onToggleFavorito: _toggleFavorito,
              isFavorita: _isFavorita,
            )
          : FavoritosPage(
              todasReceitas: _todasReceitas,
              favoritos: _favoritos,
              onToggleFavorito: _toggleFavorito,
              isFavorita: _isFavorita,
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Favoritos',
          ),
        ],
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

// Tela Home (com busca, categorias e lista)
class HomePage extends StatefulWidget {
  final List<Receita> todasReceitas;
  final Set<String> favoritos;
  final Function(String) onToggleFavorito;
  final bool Function(String) isFavorita;

  const HomePage({
    Key? key,
    required this.todasReceitas,
    required this.favoritos,
    required this.onToggleFavorito,
    required this.isFavorita,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _categoriaSelecionada = 'Todas';
  String _queryBusca = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _queryBusca = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<String> get _categoriasDisponiveis {
    final Set<String> categorias = {'Todas'};
    for (var receita in widget.todasReceitas) {
      categorias.add(receita.categoria);
    }
    return categorias.toList();
  }

  List<Receita> get _receitasFiltradas {
    List<Receita> filtradasPorCategoria = _categoriaSelecionada == 'Todas'
        ? widget.todasReceitas
        : widget.todasReceitas
              .where((r) => r.categoria == _categoriaSelecionada)
              .toList();

    if (_queryBusca.isNotEmpty) {
      filtradasPorCategoria = filtradasPorCategoria
          .where(
            (r) =>
                r.nome.toLowerCase().contains(_queryBusca) ||
                r.descricao.toLowerCase().contains(_queryBusca),
          )
          .toList();
    }

    return filtradasPorCategoria;
  }

  void _limparBusca() {
    _searchController.clear();
    setState(() {
      _queryBusca = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Receitas Fáceis'),
        backgroundColor: Colors.orange,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<String>(
              value: _categoriaSelecionada,
              dropdownColor: Colors.orange[100],
              style: TextStyle(color: Colors.orange[800]),
              items: _categoriasDisponiveis.map((String categoria) {
                return DropdownMenuItem<String>(
                  value: categoria,
                  child: Text(categoria),
                );
              }).toList(),
              onChanged: (String? novaCategoria) {
                if (novaCategoria != null) {
                  setState(() {
                    _categoriaSelecionada = novaCategoria;
                  });
                  _limparBusca();
                }
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.orange[50],
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Buscar receitas por nome ou descrição...',
                prefixIcon: Icon(Icons.search, color: Colors.orange[700]),
                suffixIcon: _queryBusca.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.orange[700]),
                        onPressed: _limparBusca,
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.orange[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.orange, width: 2),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          if (_categoriaSelecionada != 'Todas' && _queryBusca.isEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Colors.orange[50],
              child: Text(
                'Mostrando receitas de: $_categoriaSelecionada',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[800],
                ),
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: _receitasFiltradas.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search_off, size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(
                          _queryBusca.isNotEmpty
                              ? 'Nenhuma receita encontrada. Tente outra busca.'
                              : 'Nenhuma receita nesta categoria.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _receitasFiltradas.length,
                    itemBuilder: (context, index) {
                      final receita = _receitasFiltradas[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: Image.network(
                            receita.imagemUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.restaurant,
                                size: 60,
                                color: Colors.orange,
                              );
                            },
                          ),
                          title: Text(receita.nome),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                receita.descricao,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Categoria: ${receita.categoria}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: widget.isFavorita(receita.nome)
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                            onPressed: () =>
                                widget.onToggleFavorito(receita.nome),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetalhesReceitaPage(
                                  receita: receita,
                                  isFavorita: widget.isFavorita(receita.nome),
                                  onToggleFavorito: () =>
                                      widget.onToggleFavorito(receita.nome),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// Tela de Favoritos
class FavoritosPage extends StatelessWidget {
  final List<Receita> todasReceitas;
  final Set<String> favoritos;
  final Function(String) onToggleFavorito;
  final bool Function(String) isFavorita;

  const FavoritosPage({
    Key? key,
    required this.todasReceitas,
    required this.favoritos,
    required this.onToggleFavorito,
    required this.isFavorita,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filtrar receitas que são favoritas
    final List<Receita> receitasFavoritas = todasReceitas
        .where((r) => favoritos.contains(r.nome))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
        backgroundColor: Colors.orange,
      ),
      body: receitasFavoritas.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhum favorito ainda. Marque algumas receitas na aba Home!',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: receitasFavoritas.length,
              itemBuilder: (context, index) {
                final receita = receitasFavoritas[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: Image.network(
                      receita.imagemUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.restaurant,
                          size: 60,
                          color: Colors.orange,
                        );
                      },
                    ),
                    title: Text(receita.nome),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          receita.descricao,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Categoria: ${receita.categoria}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: isFavorita(receita.nome)
                            ? Colors.red
                            : Colors.grey,
                      ),
                      onPressed: () => onToggleFavorito(receita.nome),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetalhesReceitaPage(
                            receita: receita,
                            isFavorita: isFavorita(receita.nome),
                            onToggleFavorito: () =>
                                onToggleFavorito(receita.nome),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

// Tela de Detalhes da Receita (atualizada com toggle de favorita no AppBar)
class DetalhesReceitaPage extends StatelessWidget {
  final Receita receita;
  final bool isFavorita;
  final VoidCallback
  onToggleFavorito; // Callback para toggle (sem parâmetro, pois nome é fixo)

  const DetalhesReceitaPage({
    Key? key,
    required this.receita,
    required this.isFavorita,
    required this.onToggleFavorito,
  }) : super(key: key);

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.orange[800],
        ),
      ),
    );
  }

  Widget _buildSectionContent(Widget child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receita.nome),
        backgroundColor: Colors.orange,
        actions: [
          // Ícone de favorita no AppBar
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: isFavorita ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              onToggleFavorito(); // Chama o toggle
              // Mostra SnackBar no contexto da tela atual
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isFavorita
                        ? 'Removida dos favoritos.'
                        : 'Adicionada aos favoritos!',
                  ),
                  backgroundColor: isFavorita ? Colors.grey : Colors.red[400],
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              receita.imagemUrl,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: Icon(Icons.restaurant, size: 100, color: Colors.grey),
                );
              },
            ),
            _buildSectionContent(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  receita.descricao,
                  style: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
            // Mostrar categoria na tela de detalhes
            _buildSectionContent(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'Categoria: ${receita.categoria}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.orange[700],
                  ),
                ),
              ),
            ),
            _buildSectionTitle('Ingredientes'),
            _buildSectionContent(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: receita.ingredientes
                    .map(
                      (ingrediente) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.orange,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                ingrediente,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            _buildSectionTitle('Modo de Preparo'),
            _buildSectionContent(
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  receita.modoPreparo,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

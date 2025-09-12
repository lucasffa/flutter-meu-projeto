// lib/core/constants/app_strings.dart
class AppStrings {
  // App Info
  static const String appName = 'iFood Gestor';
  static const String appVersion = '1.0.0';

  // Login Page
  static const String loginTitle = 'Gestor de Pedidos';
  static const String loginSubtitle = 'Insira seu usuário e senha para se conectar';
  static const String usernameLabel = 'Usuário';
  static const String passwordLabel = 'Senha';
  static const String usernamePlaceholder = 'Digite seu usuário';
  static const String passwordPlaceholder = 'Digite sua senha';
  static const String loginButton = 'ENTRAR';
  static const String forgotPasswordButton = 'ESTOU COM PROBLEMAS PARA ACESSAR';
  static const String rememberMe = 'Lembrar de mim';

  // Validation Messages
  static const String requiredField = 'Este campo é obrigatório';
  static const String invalidEmail = 'Digite um e-mail válido';
  static const String invalidPassword = 'A senha deve ter pelo menos 6 caracteres';
  static const String invalidUsername = 'Nome de usuário deve ter pelo menos 3 caracteres';
  static const String passwordsDoNotMatch = 'As senhas não coincidem';

  // Error Messages
  static const String networkError = 'Erro de conexão. Verifique sua internet e tente novamente.';
  static const String invalidCredentials = 'Usuário ou senha inválidos';
  static const String userNotFound = 'Usuário não encontrado';
  static const String accountDisabled = 'Conta desabilitada. Contate o administrador';
  static const String accountLocked = 'Conta bloqueada. Tente novamente mais tarde';
  static const String tooManyAttempts = 'Muitas tentativas de login. Tente novamente em alguns minutos';
  static const String serverError = 'Erro no servidor. Tente novamente mais tarde';
  static const String maintenanceMode = 'Sistema em manutenção. Tente novamente mais tarde';
  static const String unknownError = 'Erro desconhecido. Tente novamente';

  // Success Messages
  static const String loginSuccess = 'Login realizado com sucesso';
  static const String logoutSuccess = 'Logout realizado com sucesso';
  static const String passwordResetSent = 'E-mail de recuperação enviado';

  // Forgot Password
  static const String forgotPasswordTitle = 'Recuperar Senha';
  static const String forgotPasswordSubtitle = 'Digite seu e-mail para receber as instruções de recuperação';
  static const String emailLabel = 'E-mail';
  static const String emailPlaceholder = 'Digite seu e-mail';
  static const String sendResetButton = 'ENVIAR INSTRUÇÕES';
  static const String backToLogin = 'Voltar ao login';

  // Dashboard
  static const String dashboardTitle = 'Dashboard';
  static const String welcome = 'Bem-vindo';
  static const String orders = 'Pedidos';
  static const String menu = 'Menu';
  static const String reports = 'Relatórios';
  static const String settings = 'Configurações';
  static const String profile = 'Perfil';
  static const String logout = 'Sair';

  // Common
  static const String ok = 'OK';
  static const String cancel = 'Cancelar';
  static const String close = 'Fechar';
  static const String save = 'Salvar';
  static const String edit = 'Editar';
  static const String delete = 'Excluir';
  static const String confirm = 'Confirmar';
  static const String loading = 'Carregando...';
  static const String retry = 'Tentar novamente';
  static const String yes = 'Sim';
  static const String no = 'Não';

  // Status
  static const String online = 'Online';
  static const String offline = 'Offline';
  static const String connecting = 'Conectando...';
  static const String connected = 'Conectado';
  static const String disconnected = 'Desconectado';

  // Time
  static const String today = 'Hoje';
  static const String yesterday = 'Ontem';
  static const String tomorrow = 'Amanhã';
  static const String thisWeek = 'Esta semana';
  static const String thisMonth = 'Este mês';

  // Orders
  static const String newOrder = 'Novo Pedido';
  static const String orderNumber = 'Pedido #';
  static const String orderStatus = 'Status';
  static const String orderTotal = 'Total';
  static const String orderDate = 'Data';
  static const String customer = 'Cliente';
  static const String items = 'Itens';

  // Status Types
  static const String pending = 'Pendente';
  static const String processing = 'Processando';
  static const String preparing = 'Preparando';
  static const String ready = 'Pronto';
  static const String delivered = 'Entregue';
  static const String cancelled = 'Cancelado';

  // Navigation
  static const String home = 'Início';
  static const String back = 'Voltar';
  static const String next = 'Próximo';
  static const String previous = 'Anterior';
  static const String finish = 'Finalizar';

  // Permissions
  static const String permissionDenied = 'Permissão negada';
  static const String insufficientPermissions = 'Permissões insuficientes';

  // Forms
  static const String required = 'Obrigatório';
  static const String optional = 'Opcional';
  static const String selectOption = 'Selecione uma opção';
  static const String noOptions = 'Nenhuma opção disponível';

  // File Operations
  static const String upload = 'Upload';
  static const String download = 'Download';
  static const String fileSelected = 'Arquivo selecionado';
  static const String noFileSelected = 'Nenhum arquivo selecionado';

  // Search
  static const String search = 'Buscar';
  static const String searchHint = 'Digite para buscar...';
  static const String noResults = 'Nenhum resultado encontrado';
  static const String searchResults = 'Resultados da busca';

  // Filters
  static const String filter = 'Filtrar';
  static const String clearFilters = 'Limpar filtros';
  static const String applyFilters = 'Aplicar filtros';

  // Accessibility
  static const String hidePassword = 'Ocultar senha';
  static const String showPassword = 'Mostrar senha';
  static const String loading_a11y = 'Carregando, aguarde';
  static const String error_a11y = 'Erro';
  static const String success_a11y = 'Sucesso';
}
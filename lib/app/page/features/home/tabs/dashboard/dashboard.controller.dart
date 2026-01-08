import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:result_dart/result_dart.dart';
import '../../../../../core/models/auth/user.model.dart';
import '../../../../../core/models/features/pet.model.dart';
import '../../../../../core/repository/auth.repository.dart';
import '../../../../../core/repository/pet.repository.dart';
import 'dashboard.state.dart';

class DashBoardTabController extends Cubit<DashBoardTabState> {
  DashBoardTabController(this._authRepository, this._petRepository)
    : super(DashBoardTabInitial());

  final IAuthRepository _authRepository;
  final IPetRepository _petRepository;

Future<void> loadData() async {
  if (isClosed) return;
  emit(DashBoardTabLoading());

  try {
    // 1. Busca o Usuário
    final userResult = await _authRepository.getCurrentUser();

    // GUARD CLAUSE: Se falhar aqui, nem tenta buscar pets. Para tudo.
    if (userResult.isError()) {
      emit(DashBoardTabError(userResult.exceptionOrNull().toString()));
      return;
    }

    // 2. Extrai o usuário (Seguro, pois já validamos o erro acima)
    final user = userResult.getOrThrow();
    
    // 3. Busca os Pets usando o ID do usuário (Chamada Dependente)
    // Nota: Geralmente usa-se o UID, mas se sua API pede token, mantenha.
    final petsResult = await _petRepository.getPetsForUser(user.id ?? ''); 

    if (isClosed) return;

    // 4. Valida o resultado dos pets
    petsResult.fold(
      (pets) => emit(DashBoardTabSuccess(
        userName: user.name ?? 'Usuário',
        pets: pets,
      )),
      (error) => emit(DashBoardTabError(error.toString())),
    );

  } catch (e) {
    emit(DashBoardTabError(e.toString()));
  }
}
}

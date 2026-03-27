import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/routine_model.dart';

class RoutineRepository {
  final _client = Supabase.instance.client;

  Future<List<Routine>> getRoutines(String tenantId) async {
    // Explicitly filtering by tenant_id
    final response = await _client
        .from('routines')
        .select()
        .eq('tenant_id', tenantId)
        .order('created_at', ascending: false);

    return (response as List).map((json) => Routine.fromJson(json)).toList();
  }

  Future<void> createRoutine(Routine routine) async {
    await _client.from('routines').insert(routine.toJson());
  }

  Future<void> updateRoutine(Routine routine) async {
    await _client
        .from('routines')
        .update(routine.toJson())
        .eq('id', routine.id)
        .eq('tenant_id', routine.tenantId); // Security: must match tenant_id
  }

  Future<void> deleteRoutine(String id, String tenantId) async {
    await _client
        .from('routines')
        .delete()
        .eq('id', id)
        .eq('tenant_id', tenantId); // Security: must match tenant_id
  }
}

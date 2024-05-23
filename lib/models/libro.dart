// ignore_for_file: non_constant_identifier_names, camel_case_types

class Libro {
  final int Id_libro;
  final String titulo;
  final String descripcion;
  final String autor;
  final String editorial;
  final int ano_publicacion;
  final int disponibles;
  final String isbn;
  final int status;

  Libro({
    required this.Id_libro,
    required this.titulo,
    required this.descripcion,
    required this.autor,
    required this.editorial,
    required this.ano_publicacion,
    required this.disponibles,
    required this.isbn,
    required this.status,
  });

  factory Libro.fromJson(Map<String, dynamic> json) {
    return Libro(
      Id_libro: int.parse(json['Id_libro']),
      titulo: json['titulo'],
      descripcion: json['descripcion'],
      autor: json['autor'],
      editorial: json['editorial'],
      ano_publicacion: int.parse(json['ano_publicacion']),
      disponibles: int.parse(json['disponibles']),
      isbn: json['isbn'],
      status: int.parse(json['status']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id_libro': Id_libro,
        'titulo': titulo,
        'descripcion': descripcion,
        'autor': autor,
        'editorial': editorial,
        'ano_publicacion': ano_publicacion,
        'disponibles': disponibles,
        'isbn': isbn,
        'status': status,
      };
}

class Produto {
  int id;
  int categoriaId;
  String nome;
  String imagem;
  String preco;
  String createdAt;
  String updatedAt;

  Produto(
      {this.id,
      this.categoriaId,
      this.nome,
      this.imagem,
      this.preco,
      this.createdAt,
      this.updatedAt});

  Produto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoriaId = json['categoria_id'];
    nome = json['nome'];
    imagem = json['imagem'];
    preco = json['preco'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoria_id'] = this.categoriaId;
    data['nome'] = this.nome;
    data['imagem'] = this.imagem;
    data['preco'] = this.preco;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}

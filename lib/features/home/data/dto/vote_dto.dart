class VoteDto {
  final String postId;
  final String voteType;

  VoteDto({required this.postId, required this.voteType});

  Map<String, dynamic> toJson() {
    return {
      'voteType': voteType,
    };
  }

  static VoteDto fromJson(Map<String, dynamic> json) {
    return VoteDto(
      postId: json['postId'],
      voteType: json['voteType'],
    );
  }
}

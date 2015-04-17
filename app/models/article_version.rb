class ArticleVersion < PaperTrail::Version
  #self.table_name = :article_versions
  scope :updates, -> {where(event: 'update')}
end

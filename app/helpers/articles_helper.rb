module ArticlesHelper

    def newest_articles
        Article.select('articles.*').order('created_at DESC').limit(5)
    end
end

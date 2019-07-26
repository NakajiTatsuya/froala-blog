class ArticlesController < ApplicationController
  before_action :find_article, only: [:edit, :update, :show, :destroy]
  before_action :hash_init, only: [:index, :new, :create, :edit]
  # before_action :restrict_remote_ip, except: [:index, :show, :tag]
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :admin_user, only: [:new, :create, :edit, :update, :destroy]

  def tag
    # INNER JOINするために joinsメソッド
    # @articles = Article.joins(:tags).where(tags: {id: params[:id]})
    @articles = Article.joins(:tags).merge(Tag.where(id: params[:id]))
  end

  def index
    @articles = Article.all
    # @tags = Tag.select('tags.*', 'count(articles.id) AS acs').left_joins(:articles).group('tags.id').order('acs desc').limit(5)
  end

  def new
    @article = Article.new
    # @article.tags.build
  end

  # Create action saves the article into database
  def create
    @article = Article.new(article_params)
    # @article.tags.build(tag_params)
    if @article.save
      flash[:notice] = "Successfully created article!"
      redirect_to article_path(@article)
    else
      flash[:alert] = "Error creating new article!"
      render :new
    end
  end

  # Edit action retrives the article and renders the edit page
  def edit
  end

  # Update action updates the article with the new information
  def update
    if @article.update_attributes(article_params)
      flash[:notice] = "Successfully updated article!"
      redirect_to article_path(@article)
    else
      flash[:alert] = "Error updating article!"
      render :edit
    end
  end

  # The show action renders the individual article after retrieving the id
  def show
  end

  # The destroy action removes the article permanently from the database
  def destroy
    if @article.destroy
      flash[:notice] = "Successfully deleted article!"
      redirect_to articles_path
    else
      flash[:alert] = "Error updating article!"
    end
  end

  # def cakephp
  #   tag = Tag.where('name=?', cakePHP)
  #   @articles = tag.articles
  #   render :index
  # end

  # def php
  #   @articles = Article.where('Tag.name=?', 'php')
  # end

  # def swift
  #   @articles = Article.where('Tag.name=?', 'swift')
  # end

  # def reactnative
  #   @articles = Article.where('Tag.name=?', 'reactnative')
  # end

  # def rubyonrails
  #   @articles = Article.where('Tag.name=?', 'rubyonrails')
  # end

  private

  def article_params
    params.require(:article).permit(:title, :body, :image, tag_ids: [])
  end

  def find_article
    @article = Article.find(params[:id])
  end

  # def tag_params
  #     params.require(:tag).permit(:name)
  # end

  def hash_init
    options = {
      bucket: 'dragonarrow',
      region: 'ap-northeast-1',
      keyStart: 'uploads/',
      acl: 'public-read',
      accessKey: Rails.application.credentials.dig(:aws, :access_key_id),
      secretKey: Rails.application.credentials.dig(:aws, :secret_access_key),
    }
    @aws_data = FroalaEditorSDK::S3.data_hash(options)
  end

  # PERMIT_ADDRESSES = ['127.0.0.1', '::1', ENV["ip_address"]].freeze
  # def restrict_remote_ip
  #   # ローカルか自分のipアドレス
  #   unless PERMIT_ADDRESSES.include?(request.remote_ip)
  #     render text: 'サービスが見つかりません', status: 503
  #   end
  # end

  def admin_user
      redirect_to(root_url, alert: '不正なアクセスです') unless user_signed_in? && current_user.admin?
  end

end
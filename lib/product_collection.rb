
# класс КоллекцияПродуктов, который может считывать все
class ProductCollection

  PRODUCT_TYPES = {
    film: {dir: 'films', class: Movie},
    book: {dir: 'book', class: Book}
  }

  def initialize(products = [])
    @products = products
  end


  def self.from_dir(dir_path)
    products = []

    PRODUCT_TYPES.each do |type, hash|
      # для получения из хэша пути к директории с файлами нужного типа
      product_dir = hash[:dir]
      # для нужного класса
      product_class = hash[:class]

      Dir[dir_path + '/' + product_dir + '/*.txt'].each do |path|
        products << product_class.from_file(path)
      end
    end

    self.new(products)
  end


  def to_a
    @products
  end

  def sort!(params)
    # Делает выбор по параметру by
    case params[:by]
    when :title
      # Если запросили сортировку по наименованию
      @products.sort_by! { |product| product.to_s }
    when :price
      # Если запросили сортировку по цене
      @products.sort_by! { |product| product.price }
    when :amount
      # Если запросили сортировку по количеству
      @products.sort_by! { |product| product.amount }
    end

    # Если запросили сортировку по возрастанию
    @products.reverse! if params[:order] == :asc

    # Возвращаем ссылку на экземпляр, чтобы у него по цепочке можно было вызвать
    # другие методы.
    self
  end

end
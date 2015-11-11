class MenuCardWidget < ActionWidget::Base
  class Item < ActionWidget::Base
    property :title
    property :description

    def render
      span(title, class: 'title') +
        span(description, class: 'description')
    end
  end

  def self.render(view, title, price, *args, **attrs, &block)
    new(view, title: title, price: price, **attrs).render(*args, &block)
  end

  property :title, required: true
  property :price

  def render(&menu_items)
    div(class: 'menu-card') do
      content_tag(:h3, title) +
        content_tag(:ul, capture(self, &menu_items), class: 'menu-items')
    end
  end

  def item(title, &description)
    content_tag(:li, Item.new(view, title: title, description: capture(&description)).render, class: 'menu-item')
  end
end

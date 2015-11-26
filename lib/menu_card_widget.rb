class MenuCardWidget < ActionWidget::Base
  class Item < ActionWidget::Base
    property :title
    property :description

    def render
      content = span(title, class: 'title')
      content << " "
      content << span(description, class: 'description') unless description.nil?
      content
    end
  end

  def self.render(view, title, *args, **attrs, &block)
    new(view, title: title, **attrs).render(*args, &block)
  end

  property :title, required: true
  property :price

  def render(&menu_items)
    div(class: 'menu-card') do
      concat content_tag(:h3, title) +
        content_tag(:ul, capture(self, &menu_items), class: 'menu-items')
    end
  end

  def item(title, &description)
    description &&= capture(&description)
    content_tag(:li, Item.new(view, title: title, description: description).render, class: 'menu-item')
  end
end

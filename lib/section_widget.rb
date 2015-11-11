class SectionWidget < ActionWidget::Base
  property :title
  property :tag, required: true, default: :h2

  def self.render(view, title = nil, **attrs, &block)
    new(view, title: title, **attrs).render(&block)
  end

  def render(&content)
    section do
      container(content_tag(tag, title), class: 'title') +
        container(&content)
    end
  end

  protected

  def section(&content)
    content_tag(:div, class: ['page-section', options[:class]], &content)
  end

  def container(content = nil, **options, &block)
    content_tag(:div, content, class: ['container', options[:class]], &block)
  end
end

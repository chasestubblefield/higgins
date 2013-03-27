module BuildsHelper
  def label_for_status(status)
    return if status == 'none'
    label_class = 'label'
    case status
    when 'success'
      label_class << ' label-success'
    when 'failure'
      label_class << ' label-important'
    when 'error'
      label_class << ' label-warning'
    end
    content_tag('span', status, class: label_class)
  end
end

module FilterBacktrace
  def self.filter_out(exception, string)
    if exception.backtrace
      new_backtrace = exception.backtrace.take_while { |l| !l.include?(string) }
      exception.set_backtrace new_backtrace
    end
  end
end

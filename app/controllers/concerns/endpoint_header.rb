module EndpointHeader
  extend ActiveSupport::Concern

  def add_header (output)
    { title: "Imagery", version: "1.0", results: output }
  end

end

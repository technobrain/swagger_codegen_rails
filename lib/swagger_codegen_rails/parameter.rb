module SwaggerCodegenRails
  class Parameter < Struct.new(:name,
                               :in,
                               :type,
                               :required)
    
    def parse_params(args)
      args.each_with_index do |idx, arg|
        self[idx] = arg
      end
    rescue IndexError => e
      logger.error e
      logger.error e.backtrace.join("\n")
      return nil
    end
  end
end

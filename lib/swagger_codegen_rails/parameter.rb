module SwaggerCodegenRails
  class Parameter < Struct.new(:name,
                               :in,
                               :type,
                               :required)
    
    def parse_params(args)
      map_params(args)
      args.each_with_index { |idx, arg| self[idx] = arg }
    rescue IndexError => e
      logger.error e
      logger.error e.backtrace.join("\n")
      return nil
    end

    def map_params(args)
      args.map! { |arg| arg.split(":") }
    end
  end
end

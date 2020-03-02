
Puppet::Functions.create_function(:helloworld) do
    dispatch :helloworld do
      optional_param 'Numeric', :tmpdir
      return_type 'String'
    end
    def helloworld(tmpdir = '/tmp/')
        open(tmpdir + 'helloworld.txt', 'a') { |f|
            f.puts Time.now.strftime("%d/%m/%Y %H:%M") + ":  Hello, world."
        }
        return "output from hello world puppet function"
    end
  end


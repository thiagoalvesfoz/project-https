cluster = {
  "nginx" => { 
    :box_image => "generic/ubuntu1804", 
    :ip => "192.168.10.50", 
    :mem => 1024,
    :script => "./nginx.sh",
    :nginx_file => "./default",
    :certificates => "./certificate"
  },
}

Vagrant.configure("2") do |config|
  
  cluster.each do |hostname, info| 

    config.vm.define hostname do |cfg|

      cfg.vm.box = info[:box_image]
      cfg.vm.box_check_update = false
      cfg.vm.network "private_network", ip: info[:ip]

      cfg.vm.provider :virtualbox do |vb, override|
        vb.name = hostname
        vb.memory = info[:mem] if info[:mem]
        vb.cpus = info[:cpus] if info[:cpus]
      end 

      cfg.vm.provision :shell, path: info[:script] if info[:script]
      
      cfg.vm.provision :file,  source: info[:certificates], destination: "/etc/nginx/certificate" if info[:certificates]
      cfg.vm.provision :file,  source: info[:nginx_file], destination: "/etc/nginx/sites-available/" if info[:nginx_file]

      cfg.vm.provision :shell, inline: "sudo service nginx restart"
    end #end config
    end #end loop
  
end #end vagrant
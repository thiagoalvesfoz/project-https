cluster = {
  "nginx" => { 
    :box_image => "generic/ubuntu1804", 
    :ip => "192.168.10.50", 
    :mem => 1024,
    :script => "./install.sh",
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
      
      cfg.vm.provision :file,  source: "./ssl.conf", destination: "/tmp/ssl.conf"      
      
      cfg.vm.provision :shell, inline: <<-SHELL     
        mv /tmp/ssl.conf /etc/nginx/sites-available/ssl.conf        
        ln -s /etc/nginx/sites-available/ssl.conf /etc/nginx/sites-enabled/ssl.conf
        sudo service nginx restart
      SHELL

    end #end config
    end #end loop
  
end #end vagrant
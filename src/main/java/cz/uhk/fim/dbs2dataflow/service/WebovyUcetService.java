package cz.uhk.fim.dbs2dataflow.service;

import cz.uhk.fim.dbs2dataflow.model.WebovyUcet;
import cz.uhk.fim.dbs2dataflow.model.WebovyUcetUserDetails;
import cz.uhk.fim.dbs2dataflow.repository.WebovyUcetRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WebovyUcetService implements UserDetailsService {
    @Autowired
    WebovyUcetRepository webovyUcetRepository;
    public List<WebovyUcet> getAll(){
        return (List<WebovyUcet>) webovyUcetRepository.findAll();
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        WebovyUcet webovyUcet = webovyUcetRepository.findWebovyUcetByJmeno(username);
        if (webovyUcet == null){
            throw new UsernameNotFoundException("ucet not found");
        }
        return new WebovyUcetUserDetails(webovyUcet);
    }
}

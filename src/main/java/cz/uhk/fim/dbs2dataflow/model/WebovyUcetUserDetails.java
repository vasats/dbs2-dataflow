package cz.uhk.fim.dbs2dataflow.model;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Collections;

public class WebovyUcetUserDetails implements UserDetails {
    private WebovyUcet ucet;

    public WebovyUcetUserDetails(WebovyUcet ucet) {
        this.ucet = ucet;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return Collections.singleton(new SimpleGrantedAuthority(ucet.getTypuctu()));
    }

    @Override
    public String getPassword() {
        return ucet.getHesloHash();
    }

    @Override
    public String getUsername() {
        return ucet.getJmeno();
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }
}

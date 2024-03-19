package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;

@Entity
@Table
public class Adresa {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    
    
}

package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;


@Entity
@Table
public class Hala {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer halaID;
}

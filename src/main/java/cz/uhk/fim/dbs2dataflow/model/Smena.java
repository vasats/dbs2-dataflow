package cz.uhk.fim.dbs2dataflow.model;

import jakarta.persistence.*;

import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Table
public class Smena {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private LocalTime casDo;
    private LocalTime casOd;
    private LocalDate datumOd;
}

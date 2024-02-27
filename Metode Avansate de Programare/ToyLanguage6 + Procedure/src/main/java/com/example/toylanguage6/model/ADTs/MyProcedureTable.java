package com.example.toylanguage6.model.ADTs;

import com.example.toylanguage6.model.Statements.StatementInterface;
import javafx.util.Pair;

import java.util.List;

public class MyProcedureTable extends MyDictionary<String, Pair<List<String>, StatementInterface>> implements MyProcedureTableInterface{
    // nothing to add here because MyDictionary already implements MyProcedureTableInterface
}

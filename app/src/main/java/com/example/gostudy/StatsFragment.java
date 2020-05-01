package com.example.gostudy;

import android.graphics.Color;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import com.jjoe64.graphview.GraphView;
import com.jjoe64.graphview.ValueDependentColor;
import com.jjoe64.graphview.series.BarGraphSeries;
import com.jjoe64.graphview.series.DataPoint;

import java.util.ArrayList;

public class StatsFragment extends Fragment implements AdapterView.OnItemSelectedListener {

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater,
                             ViewGroup container, Bundle savedInstanceState){
        System.out.println(1);
        View root = inflater.inflate(R.layout.fragment_stats, container, false);
        System.out.println(2);
        GraphView graph = (GraphView) root.findViewById(R.id.cmgraph);
        System.out.println(3);
        BarGraphSeries<DataPoint> series = new BarGraphSeries<>(new DataPoint[] {
                new DataPoint( 49,  4 ),
                new DataPoint(  59 , 1),
                new DataPoint(64 , 0),
                new DataPoint( 69,  9),
                new DataPoint( 74, 14),
                new DataPoint(  79, 6),
                new DataPoint(  84, 18),
                new DataPoint(  89,  16 ),
                new DataPoint( 94, 8),
                new DataPoint(  100, 3),
        });
        System.out.println(4);
        graph.addSeries(series);
        // styling
        System.out.println(5);
        series.setValueDependentColor(new ValueDependentColor<DataPoint>() {
            @Override
            public int get(DataPoint data) {
                return Color.rgb(00, 00, 255);
            }

        });

        // draw values on top
        series.setDrawValuesOnTop(true);
        series.setValuesOnTopColor(Color.RED);
        System.out.println(5);
        Spinner statsSpinner = root.findViewById(R.id.statsSpnr);
        ArrayList<String> courses = new ArrayList<>();
        courses.add("2019/2020 Semester A");
        courses.add("2019/2020 Semester B");
        courses.add("2018/2019 Semester A");
        courses.add("2018/2019 Semester B");
        System.out.println(6);
        ArrayAdapter<String> arrayAdapter = new ArrayAdapter<String>(this.getActivity(), android.R.layout.simple_spinner_item, courses);
        System.out.println(7);
        arrayAdapter.setDropDownViewResource(android.R.layout.simple_spinner_dropdown_item);
        System.out.println(8);
        statsSpinner.setAdapter(arrayAdapter);
        System.out.println(9);
        return root;


    }

    @Override
    public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {

    }

    @Override
    public void onNothingSelected(AdapterView<?> parent) {

    }
}

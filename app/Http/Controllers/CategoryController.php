<?php

namespace App\Http\Controllers;

use App\CustomClass\OwnLibrary;
use App\Models\Category;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    public function index()
    {
        $categories = Category::with('category')->orderBy('id','DESC')->paginate(20);
        $paginate = OwnLibrary::paginationSerial($categories);
        return view('backend.category.index',compact('categories','paginate'));
    }


    public function create()
    {
        $categories = Category::select('id','name')->orderBy('name')->where('category_id','=',null)->where('status','=',1)->get();
        return view('backend.category.create',compact('categories'));
    }

    public function store(Request $request)
    {
        $rules = [
            'name' => 'required|max:250'
        ];

        $message = [];

        $validator = validator($request->all(),$rules,$message);

        if ($validator->fails()){
            return redirect()->back()->withInput()->withErrors($validator);
        }

        $category = new Category();
        $category->name = $request->name;
        $category->category_id = $request->category_id;

        if ($category->save()){
            session()->flash("success", "Data successfully created");
            return redirect()->route("categories.index");
        }else{
            session()->flash("error", "Data not created");
            return redirect()->back()->withInput();
        }

    }

    public function edit(Category $category)
    {
        $categories = Category::select('id','name')->orderBy('name')->where('category_id','=',null)->where('status','=',1)->get();
        return view('backend.category.edit',compact('category','categories'));
    }

    public function update(Request $request, Category $category)
    {
        $rules = [
            'name' => 'required|max:250'
        ];

        $message = [];

        $validator = validator($request->all(),$rules,$message);

        if ($validator->fails()){
            return redirect()->back()->withInput()->withErrors($validator);
        }

        $category->name = $request->name;
        $category->category_id = $request->category_id;
        $category->status = $request->status;

        if ($category->save()){
            session()->flash("success", "Data successfully updated");
            return redirect()->route("categories.index");
        }else{
            session()->flash("error", "Data not updated");
            return redirect()->back()->withInput();
        }
    }

    public function destroy(Category $category)
    {
        if ($category->delete()){
            session()->flash("success", "Data deleted");
        }else{
            session()->flash("error", "Data unable to delete");
        }
        return redirect()->route("categories.index");
    }
}
#ifndef CIRCULAR_ARRAY_HXX
#define CIRCULAR_ARRAY_HXX

#include "library.hxx"
template<typename T>
class Circular_Array
{
 private:
     T* arr;
     int size_array;
     int start_index;
 
 public:
    Circular_Array() = default;
    Circular_Array(const int size) : arr{new T[size]}, size_array(size), start_index(0){}
    Circular_Array(std::vector<T> mass) : size_array(mass.size()), start_index(0)
    {
        size_array = mass.size();
        arr = new T[size_array];
        for(int i = 0; i < size_array; i++)
        {
            arr[i] = mass[i];
        }
    }
    ~Circular_Array()
    {
        delete[] arr;
        arr = NULL;
    }

    void push(T elem)
    {
        arr[start_index] = elem;
        if(start_index + 1 < size_array)
        {
            start_index++;
        }
        else
        {
            start_index -= (size_array-1);
        }
    }

    T operator[](const int index)
    {
        int real_index = index + start_index;
        if(real_index >= size_array)
        {
            return arr[real_index - size_array];
        }
        else
        {
            return arr[real_index];
        }
    }

    explicit operator std::vector<T>()
    {
        std::vector<T> res(size_array);
        for(int i = 0; i < size_array; i++)
        {
            res[i] = operator[](i);
        }
        return res;
    }
};

#endif // CIRCULAR_ARRAY_HXX

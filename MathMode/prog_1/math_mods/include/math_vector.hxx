#ifndef MATH_VECTOR_HXX
#define MATH_VECTOR_HXX

#include "library.hxx"

template <typename T>
class Math_Vector : private std::vector<T>
{
    public:
        using std::vector<T>::vector;
        using std::vector<T>::operator[];
        using std::vector<T>::size;
};

template <typename T>
double Math_Abs(const Math_Vector<T> temp_vector)
{
    T sqr_summa = 0.0;
    for (size_t i = 0; i < temp_vector.size(); i++)
    {
        sqr_summa += temp_vector[i] * temp_vector[i];
    }
    return std::sqrt(sqr_summa);
}

template <typename T>
Math_Vector<T>& operator+=(Math_Vector<T>& left_hs, const Math_Vector<T>& right_hs)
{
    const size_t vector_size = left_hs.size();
    for (size_t counter = 0; counter < vector_size; counter++)
    {
        left_hs[counter] += right_hs[counter];
    }
    return left_hs;
}
template <typename T>
Math_Vector<T>& operator-=(Math_Vector<T>& left_hs, const Math_Vector<T>& right_hs)
{
    const size_t vector_size = right_hs.size();
    for (size_t counter = 0; counter < vector_size; counter++)
    {
        left_hs[counter] -= right_hs[counter];
    }
    return left_hs;
}
template <typename T>
Math_Vector<T>& operator*=(const Math_Vector<T>& left_hs, const T right_hs)
{
    const size_t vector_size = left_hs.size();
    for (size_t counter = 0; counter < vector_size; counter++)
    {
        left_hs[counter] *= right_hs;
    }
    return left_hs;
}
template <typename T>
Math_Vector<T>& operator/=(const Math_Vector<T>& left_hs, const T right_hs)
{
    const size_t vector_size = left_hs.size();
    for (size_t counter = 0; counter < vector_size; counter++)
    {
        left_hs[counter] /= right_hs;
    }
    return left_hs;
}
template <typename T>
Math_Vector<T> operator+(const Math_Vector<T>& left_hs, const Math_Vector<T>& right_hs)
{
    const size_t vector_size = left_hs.size();
    Math_Vector<T> res_vector(vector_size);
    for (size_t counter = 0; counter < vector_size; counter++)
    {
        res_vector[counter] = left_hs[counter] + right_hs[counter];
    }
    return res_vector;
}
template <typename T>
Math_Vector<T> operator-(const Math_Vector<T>& left_hs, const Math_Vector<T>& right_hs)
{
    const size_t vector_size = left_hs.size();
    Math_Vector<T> res_vector(vector_size);
    for (size_t counter = 0; counter < vector_size; counter++)
    {
        res_vector[counter] = left_hs[counter] - right_hs[counter];
    }
    return res_vector;
}
template <typename T>
Math_Vector<T> operator*(const T left_hs, const Math_Vector<T>& right_hs)
{
    const size_t vector_size = right_hs.size();
    Math_Vector<T> res_vector(vector_size);
    for (size_t counter = 0; counter < vector_size; counter++)
    {
        res_vector[counter] = left_hs * right_hs[counter];
    }
    return res_vector;
}
template <typename T>
Math_Vector<T> operator*(const Math_Vector<T>& left_hs, const T right_hs)
{
    const size_t vector_size = left_hs.size();
    Math_Vector<T> res_vector(vector_size);
    for (size_t counter = 0; counter < vector_size; counter++)
    {
        res_vector[counter] = left_hs[counter] * right_hs;
    }
    return res_vector;
}
template <typename T>
Math_Vector<T> operator/(const Math_Vector<T>& left_hs, const T right_hs)
{
    const size_t vector_size = left_hs.size();
    Math_Vector<T> res_vector(vector_size);
    for (size_t counter = 0; counter < vector_size; counter++)
    {
        res_vector[counter] = left_hs[counter] / right_hs;
    }
    return res_vector;
}
template <typename T>
std::ostream& operator<<(std::ostream& out, Math_Vector<T> vec)
{
    for(int i = 0; i < vec.size(); i++)
    {
        out << vec[i] << "\t";
    }
    return out;
}

#endif // MATH_VECTOR_HXX
